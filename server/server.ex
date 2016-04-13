defmodule ChatServer do
    # Import the Messages module, which keeps track of all message-related state
    # between requests. This could also be expanded out to keep track of much more than
    # just strings.
    require Messages
    # TODO: soon I'll also import an adapter here that will expose Phoenix connections
    # (websockets to browsers, I think?).
    
    def main() do
        IO.puts "Launching server..."

        case get_msg(:get, 0) do
           {:ok, msg} -> IO.puts msg
           {:err, msg} -> IO.puts "Warning: " <> msg
        end
        
        # I created a fairly simple user module that keeps track of different user state.
        # It forks off a separate process whenever you can User.create(), meaning this 
        # can conceivably be used for generating generic User state containers ('objects').
        #
        # Create a new user that'll have the default name of 'Anonymous'
        {:ok, current} = User.create(:luke)
        original = User.get(current, :name) # get the current name (default: Anonymous)
        IO.puts "Original name: " <> original
        # Change the name to Luke
        User.set(current, {:name, "Paul Bunyan"}) # set name to something else
        User.set(current, {:age, 47}) # set age to something else
        newer = User.get(current, :name) # get the name to confirm its 'Paul Bunyan'
        age = User.get(current, :age) # get the age to confirm its 47
        IO.puts "Player, age: " <> newer <> ", " <> to_string(age)
    end
    
    # get_msg has two clauses, and Elixir will try to match in the order that they're defined.
    # That means that effectively I think this is kinda like:
    #
    # def get_msg(op) do
    #   if (op === :ok) return "success!";
    #   else return "not correct...";
    # end
    #
    # ...in a procedural language.
    def get_msg(:get, _) do
        {:ok, "success!"}
    end
    
    def get_msg(op, _) do
        {:err, "not correct..."} 
    end
end