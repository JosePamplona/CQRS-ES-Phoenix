defmodule Conduit.Accounts.Projections.User do
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "accounts_users" do
    field :username, :string, unique: true
    field :email, :string, unique: true
    field :pass_hash, :string
    field :bio, :string
    field :image, :string

    timestamps()
  end
end