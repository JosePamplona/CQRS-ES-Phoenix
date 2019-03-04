defmodule Conduit.Accounts.Commands.RegisterUser do
  defstruct [
    :uuid,
    :username,
    :email,
    :pass,
    :pass_hash,
  ]
  
  use ExConstructor
end