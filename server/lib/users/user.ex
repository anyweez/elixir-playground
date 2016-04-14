defmodule UserService.User do 
    
    def create(id) do
        Agent.start_link(fn -> %{:name => "Anonymous", :age => nil} end, name: id)
    end
    
    def set(agent, val) do
        Agent.update(agent, fn current ->
            case val do
                {:name, name} -> Map.update!(current, :name, fn _ -> name end)
                {:age, age} -> Map.update!(current, :age, fn _ -> age end)
            end
        end)
    end
    
    def get(agent, property) do
        Agent.get(agent, fn current -> Map.get(current, property) end)
    end
end