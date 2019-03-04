defmodule ConduitWeb.Router do
  use ConduitWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ConduitWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/users", UserController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", ConduitWeb do
  #   pipe_through :api
  # end
      
  if Mix.env == :dev do
    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: Conduit.Graphql.Schema,
      interface: :advanced,
      context: %{pubsub: Conduit.Endpoint}
  end

end
