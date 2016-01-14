ExUnit.start

Mix.Task.run "ecto.create", ~w(-r GenComp.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r GenComp.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(GenComp.Repo)

