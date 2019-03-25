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
    plug Guardian.Plug.VerifyHeader, realm: "Token"
    plug Guardian.Plug.LoadResource
  end

  scope "/api", ConduitWeb do
    pipe_through :api

    get "/user", UserController, :current
    post "/users/login", SessionController, :create
    post "/users", UserController, :create
    get "/articles", ArticleController, :index
    post "/articles", ArticleController, :create
    get "/articles/:slug", ArticleController, :show
  end

  scope "/", ConduitWeb do
    pipe_through :browser

    get "/", PageController, :index
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
