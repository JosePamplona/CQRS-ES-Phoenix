defmodule Conduit.Accounts.Events.UserRegistered do
  @derive Jason.Encoder
  defstruct [
    :uuid,
    :username,
    :email,
    :pass_hash
  ]
end