defmodule Conduit.Graphql.Schema do
  @moduledoc false

  use Absinthe.Schema

  import_types Conduit.Graphql.Queries
  import_types Conduit.Graphql.Mutations
  import_types Conduit.Graphql.Subscriptions
  import_types Absinthe.Plug.Types
  import_types Absinthe.Type.Custom

  query [], do: import_fields :queries
  mutation [], do: import_fields :mutations
  subscription [], do: import_fields :subscriptions
end
