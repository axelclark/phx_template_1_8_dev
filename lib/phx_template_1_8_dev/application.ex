defmodule PhxTemplate18Dev.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhxTemplate18DevWeb.Telemetry,
      PhxTemplate18Dev.Repo,
      {DNSCluster,
       query: Application.get_env(:phx_template_1_8_dev, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhxTemplate18Dev.PubSub},
      # Start a worker by calling: PhxTemplate18Dev.Worker.start_link(arg)
      # {PhxTemplate18Dev.Worker, arg},
      # Start to serve requests, typically the last entry
      PhxTemplate18DevWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxTemplate18Dev.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxTemplate18DevWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
