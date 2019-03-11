defmodule Conduit.Accounts.Commands.RegisterUser do
  defstruct [
    :uuid,
    :username,
    :email,
    :pass_hash
  ]

  # The convention rule specifies that the 'use' directive must be before the
  # defstruct macro, but this case these deps needs the struct to be declared first
  use ExConstructor
  use Vex.Struct

  validates :uuid, uuid: true
  validates :username, presence: [message: "can't be empty"], string: true, unique_username: true
  validates :email, presence: [message: "can't be empty"], string: true
  validates :pass_hash, presence: [message: "can't be empty"], string: true
end

defimpl Conduit.Support.Middleware.Uniqueness.UniqueFields, for: Conduit.Accounts.Commands.RegisterUser do
  def unique(_command), do: [
    {:username, "has already been taken"},
  ]
end