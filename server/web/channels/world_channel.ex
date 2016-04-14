defmodule Chatserver.WorldChannel do 
    use Phoenix.Channel
    
    # Join gets called for the initial handshake. You can filter and pattern match on channel
    # names here.
    def join("world:first", _message, socket) do
        {:ok, socket}
    end
    
    def join("world:" <> _private_room, _params, _socket) do
        {:error, %{reason: "unauthorized"}}  
    end
    
    # Handle inbound messages. In this case we're just sending them to all connected clients.
    def handle_in("new_msg", %{"body" => body}, socket) do
        broadcast! socket, "new_msg", %{body: body}
        {:noreply, socket}
    end
    
    # Not actually required in this case, but this is called for every messages that's 
    # being sent to a client. In this case it's basically an extra filter on outbound messages 
    # including broadcasts. The example in the docs was filtering by users who have explicitly
    # blocked other users.
    #   http://www.phoenixframework.org/docs/channels
    def handle_out("new_msg", payload, socket) do
        push socket, "new_msg", payload
        {:noreply, socket}
    end
end