defmodule Conduit.Accounts.Commands.RegisterUser do
  defstruct [
    :uuid,
    :username,
    :email,
    :password,
    :pass_hash
  ]

  use ExConstructor
end