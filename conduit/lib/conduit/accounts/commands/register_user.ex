defmodule Conduit.Accounts.Commands.RegisterUser do
  defstruct [
    :uuid,
    :username,
    :email,
    :pass_hash
  ]

  use ExConstructor
  use Vex.Struct

  validates :uuid, uuid: true
  validates :username, presence: true, string: true
  validates :email, presence: true, string: true
  validates :pass_hash, presence: true, string: true
end