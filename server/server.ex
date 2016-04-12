defmodule ChatServer do
    # Import the Messages module, which keeps track of all message-related state
    # between requests. This could also be expanded out to keep track of much more than
    # just strings.
    require Messages
    # TODO: soon I'll also import an adapter here that will expose Phoenix connections
    # (websockets to browsers, I think?).
    
    def main() do
        IO.puts "Hello, world!"

        case get_msg(:get, 0) do
           {:ok, msg} -> IO.puts msg
           {:err, msg} -> IO.puts "Warning: " <> msg
        end
        
        IO.puts Messages.announce()
    end
    
    # get_msg has two clauses, and Elixir will try to match in the order that they're defined.
    # That means that effectively I think this is kinda like:
    #
    # def get_msg(op, param) do
    #   if (op === :ok) return "success!";
    #   else return "not correct...";
    # end
    #
    # ...in a procedural language.
    def get_msg(:get, param) do
        {:ok, "success!"}
    end
    
    def get_msg(op, param) do
        {:err, "not correct..."} 
    end
end