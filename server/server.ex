defmodule ChatServer do
    # Import the Messages module, which keeps track of all message-related state
    # between requests. This could also be expanded out to keep track of much more than
    # just strings.
    require Messages
    
    def main() do
        IO.puts "Hello, world!"

        case get_msg(:get, 0) do
           {:ok, msg} -> IO.puts msg
           {:err, msg} -> IO.puts "Warning: " <> msg
        end
        
        IO.puts Messages.announce()
    end
    
    def get_msg(:get, param) do
        {:ok, "success!"}
    end
    
    def get_msg(op, param) do
        {:err, "not correct..."} 
    end
end