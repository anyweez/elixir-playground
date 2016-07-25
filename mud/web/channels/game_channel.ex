defmodule Mud.GameChannel do 
    use Phoenix.Channel

    @doc "Accept new users into the channel"
    def join("game:" <> room_id, message, socket) do
#        world = Agent.get(:world, fn world -> world end)
        socket = assign(socket, :room_id, room_id)
        IO.puts "New user in room " <> socket.assigns.room_id

        {:ok, socket}
    end

    @doc "Example action handler"
    def handle_in("action:move", _payload, socket) do
        IO.puts "User moved from " <> socket.assigns.room_id <> " to 10"
        # Check to see if the move is valid.
        #   If so, send back new room ID.
        #   If not, return existing room ID.
        push(socket, "state:change", %{ roomId: 10 })

        {:noreply, socket}
    end

    def terminate(reason, socket) do
        IO.puts "User left room " <> socket.assigns.room_id
        :ok
    end
end