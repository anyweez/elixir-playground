defmodule Mud.World do
    defstruct \
        players: [],
        secret: "From the world"

    def start_link(name) do
        Agent.start_link(fn -> %Mud.World{} end, name: name)
    end

    def add_player(target, player) do
        IO.puts 'Adding a player'
 #       Agent.update(target, fn world -> world.players = [world.players | player] end)
    end
end