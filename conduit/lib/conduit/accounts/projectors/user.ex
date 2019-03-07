defmodule Conduit.Accounts.Projectors.User do
  use Commanded.Projections.Ecto, name: "Accounts.Projectors.User"

  alias Conduit.Accounts.Events.UserRegistered
  alias Conduit.Accounts.Projections.User

  project %UserRegistered{} = registered do
    Ecto.Multi.insert(multi, :user, %User{
      uuid: registered.uuid,
      username: registered.username,
      email: registered.email,
      pass_hash: registered.pass_hash,
      bio: nil,
      image: nil,
    })
  end
end