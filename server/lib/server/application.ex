defmodule Server.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    start_cowboy()
    # List all child processes to be supervised
    children = []

    opts = [strategy: :one_for_one, name: Server.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def start_cowboy() do
    route1 = {"/", Server.Web.PageHandler, []}
    route2 = {"/2", Server.Web.PageHandler, []}

    dispatch =
      :cowboy_router.compile([
        {:_,
         [
           route1,
           route2
         ]}
      ])

    opts = [port: 4000]
    env = [dispatch: dispatch]

    case :cowboy.start_http(:http, 10, opts, env: env) do
      {:ok, _pid} -> IO.puts("cowboy is now running, Go to http://localhost:4000")
      _ -> IO.puts("there was an error starting Cowboy web server")
    end
  end
end
