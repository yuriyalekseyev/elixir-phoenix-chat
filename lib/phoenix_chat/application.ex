defmodule PhoenixChat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      PhoenixChat.Repo,
      # Start the Telemetry supervisor
      PhoenixChatWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PhoenixChat.PubSub},
      # Start the Endpoint (http/https)
      PhoenixChatWeb.Endpoint
      # Start a worker by calling: PhoenixChat.Worker.start_link(arg)
      # {PhoenixChat.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixChat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PhoenixChatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
