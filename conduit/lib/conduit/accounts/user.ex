defmodule Conduit.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "accounts_users" do
    field :bio, :string
    field :email, :string
    field :image, :string
    field :pass_hash, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :pass_hash, :bio, :image])
    |> validate_required([:username, :email, :pass_hash, :bio, :image])
  end
end
