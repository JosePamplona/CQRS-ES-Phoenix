defmodule Conduit.Accounts.Events.UserRegistered do
  @derive Jason.Encoder
  defstruct [
    :user_uuid,
    :username,
    :email,
    :pass_hash
  ]
end