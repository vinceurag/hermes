defmodule Hermes.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    topologies = [
      hermes_local: [
        strategy: Cluster.Strategy.LocalEpmd
      ]
    ]

    children = [
      {Cluster.Supervisor, [topologies, [name: Hermes.ClusterSupervisor]]},
      {Registry, keys: :duplicate, name: Hermes.Registry},
      Hermes.PGServer
    ]

    opts = [strategy: :one_for_one, name: Hermes.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
