defmodule Conduit.Accounts.Commands.RegisterUser do
  alias Conduit.Accounts.Commands.RegisterUser
  alias Conduit.Auth

  defstruct [
    uuid: "",
    username: "",
    email: "",
    pass: "",
    pass_hash: ""
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
  validates :email,
    presence: [message: "can't be empty"],
    format: [
      with: ~r/\S+@\S+\.\S+/, 
      allow_nil: true, 
      allow_blank: true, 
      message: "format is invalid"
    ],
    string: true,
    unique_email: true
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

  @doc """
  Convert email address to lowercase characters
  """
  def downcase_email(%RegisterUser{email: email} = register_user) do
    %RegisterUser{register_user | email: String.downcase(email)}
  end

  @doc """
  Hash the password, clear the original password
  """
  def hash_pass(%RegisterUser{pass: pass} = register_user) do
    %RegisterUser{register_user |
      pass: nil,
      pass_hash: Auth.hash_password(pass)
    }
  end
end

defimpl Conduit.Support.Middleware.Uniqueness.UniqueFields, for: Conduit.Accounts.Commands.RegisterUser do
  def unique(_command), do: [
    {:email, "has already been taken"},
    {:username, "has already been taken"}
  ]
end