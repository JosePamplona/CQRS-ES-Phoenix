defmodule Conduit.Accounts.Aggregates.User do
  defstruct [
    :uuid,
    :username,
    :email,
    :pass_hash
  ]

  alias Conduit.Accounts.Aggregates.User
  alias Conduit.Accounts.Commands.RegisterUser
  alias Conduit.Accounts.Events.UserRegistered

  @doc """
  Register a new user
  """
  def execute(%User{uuid: nil}, %RegisterUser{} = register) do
    %UserRegistered{
      uuid: register.uuid,
      username: register.username,
      email: register.email,
      pass_hash: register.pass_hash
    }
  end

  # state mutators

  def apply(%User{} = user, %UserRegistered{} = registered) do
    %User{user |
      uuid: registered.uuid,
      username: registered.username,
      email: registered.email,
      pass_hash: registered.pass_hash
    }
  end
end