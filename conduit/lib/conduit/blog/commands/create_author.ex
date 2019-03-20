defmodule Conduit.Blog.Commands.CreateAuthor do
  alias Conduit.Blog.Commands.CreateAuthor

  defstruct [
    author_uuid: "",
    user_uuid: "",
    username: "",
  ]

  # The convention rule specifies that the 'use' directive must be before the
  # defstruct macro, but this case these deps needs the struct to be declared first
  use ExConstructor
  use Vex.Struct

  validates :author_uuid, 
    uuid: true

  validates :user_uuid, 
    uuid: true

  validates :username,
    presence: [message: "can't be empty"],
    format: [
      with: ~r/^[a-z0-9]+$/, 
      allow_nil: true, 
      allow_blank: true, 
      message: "is invalid"
    ],
    string: true

  @doc """
  Assign a unique identity
  """
  def assign_uuid(%CreateAuthor{} = create_author, uuid) do
    %CreateAuthor{create_author | author_uuid: uuid}
  end
end