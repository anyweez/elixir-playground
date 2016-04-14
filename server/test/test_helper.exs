ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Chatserver.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Chatserver.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Chatserver.Repo)

