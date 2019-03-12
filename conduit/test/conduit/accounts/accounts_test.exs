defmodule Conduit.AccountsTest do
  use Conduit.DataCase

  alias Conduit.Accounts
  alias Conduit.Accounts.Projections.User

  describe "register user" do
    @tag :integration
    test "should succeed with valid data" do
      assert {:ok, %User{} = user} = Accounts.register_user(build(:user))

      assert user.username == "jake"
      assert user.email == "jake@jake.jake"
      assert user.pass_hash == "jakejake"
      assert user.bio == nil
      assert user.image == nil
    end

    @tag :integration
    test "should fail with invalid data and return error" do
      assert {:error, :validation_failure, errors} = Accounts.register_user(build(:user, username: ""))

      assert errors == %{username: ["can't be empty"]}
    end

    @tag :integration
    test "should fail when username already taken and return error" do
      assert {:ok, %User{}} = Accounts.register_user(build(:user))
      assert {:error, :validation_failure, errors} = Accounts.register_user(build(:user, email: "jake2@jake.jake"))

      assert errors == %{username: ["has already been taken"]}
    end

    @tag :integration
    test "should fail when registering identical username at same time and return error" do
      1..2
      |> Enum.map(fn i -> 
        Task.async(fn -> 
          :user
          |> build(email: "jake#{i}@jake.jake")
          |> Accounts.register_user() 
        end) 
      end)
      |> Enum.map(&Task.await/1)
    end

    @tag :integration
    test "should fail when username format is invalid and return error" do
      assert {:error, :validation_failure, errors} = Accounts.register_user(build(:user, username: "j@ke"))

      assert errors == %{username: ["format is invalid"]}
    end

    @tag :integration
    test "should convert username to lowercase" do
      assert {:ok, %User{} = user} = Accounts.register_user(build(:user, username: "JAKE"))

      assert user.username == "jake"
    end

    @tag :integration
    test "should fail when email address already taken and return error" do
      assert {:ok, %User{}} = Accounts.register_user(build(:user, username: "jake"))
      assert {:error, :validation_failure, errors} = Accounts.register_user(build(:user, username: "jake2"))

      assert errors == %{email: ["has already been taken"]}
    end

    @tag :integration
    test "should fail when registering identical email addresses at same time and return error" do
      1..2
      |> Enum.map(fn i -> 
        Task.async(fn -> 
          :user
          |> build(username: "user#{i}")
          |> Accounts.register_user() 
        end)  
      end)
      |> Enum.map(&Task.await/1)
    end

    @tag :integration
    test "should fail when email address format is invalid and return error" do
      assert {:error, :validation_failure, errors} = Accounts.register_user(build(:user, email: "invalidemail"))

      assert errors == %{email: ["format is invalid"]}
    end

    @tag :integration
    test "should convert email address to lowercase" do
      assert {:ok, %User{} = user} = Accounts.register_user(build(:user, email: "JAKE@JAKE.JAKE"))

      assert user.email == "jake@jake.jake"
    end
    
  end
end