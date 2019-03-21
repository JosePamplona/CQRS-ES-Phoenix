defmodule Conduit.Factory do
  use ExMachina

  alias Conduit.Accounts.Commands.RegisterUser
  alias Conduit.Blog.Commands.PublishArticle

  def article_factory do
    %{
      slug: "how-to-train-your-dragon",
      title: "How to train your dragon",
      description: "Ever wonder how?",
      body: "You have to believe",
      tag_list: ["dragons", "training"],
      author_uuid: UUID.uuid4(),
    }
  end

  def author_factory do
    %{
      user_uuid: UUID.uuid4(),
      username: "jake",
      bio: "I like to skateboard",
      image: "https://i.stack.imgur.com/xHWG8.jpg",
    }
  end

  def user_factory do
    %{
      email: "jake@jake.jake",
      username: "jake",
      password: "jakejake",
      hashed_password: "hashed_jakejake",
      bio: "I like to skateboard",
      image: "https://i.stack.imgur.com/xHWG8.jpg",
    }
  end

  def register_user_factory, do: struct(RegisterUser, build(:user))

  def publish_article_factory, do: struct(PublishArticle, build(:article))
end