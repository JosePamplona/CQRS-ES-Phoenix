defmodule Conduit.Accounts.Events.UserRegistered do
  @derive [Poison.Encoder]
  defstruct [
    :uuid,
    :username,
    :email,
    :pass_hash,
  ]
end