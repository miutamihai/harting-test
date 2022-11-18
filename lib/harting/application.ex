defmodule Harting.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      HartingWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Harting.PubSub},
      # Start the Endpoint (http/https)
      HartingWeb.Endpoint,
      # Start a worker by calling: Harting.Worker.start_link(arg)
      # {Harting.Worker, arg}
      {Desktop.Window, app: :harting, id: MainWindow, url: &HartingWeb.Endpoint.url/0}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Harting.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HartingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
