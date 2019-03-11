defmodule Conduit.Accounts.Commands.RegisterUser do
  alias Conduit.Accounts.Commands.RegisterUser

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
  validates :username, 
    presence: [message: "can't be empty"], 
    format: [
      with: ~r/^[a-z0-9]+$/, 
      allow_nil: true, 
      allow_blank: true, 
      message: "format is invalid"
    ],
    string: true, 
    unique_username: true
  validates :email, presence: [message: "can't be empty"], string: true
  validates :pass_hash, presence: [message: "can't be empty"], string: true

  @doc """
  Assign a unique identity for the user
  """
  def assign_uuid(%RegisterUser{} = register_user, uuid) do
    %RegisterUser{register_user | uuid: uuid}
  end

  @doc """
  Convert username to lowercase characters
  """
  def downcase_username(%RegisterUser{username: username} = register_user) do
    %RegisterUser{register_user | username: String.downcase(username)}
  end
end

defimpl Conduit.Support.Middleware.Uniqueness.UniqueFields, for: Conduit.Accounts.Commands.RegisterUser do
  def unique(_command), do: [
    {:username, "has already been taken"},
  ]
end