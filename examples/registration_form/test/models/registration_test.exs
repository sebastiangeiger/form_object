defmodule RegistrationForm.RegistrationTest do
  use RegistrationForm.ModelCase

  alias RegistrationForm.Registration
  alias RegistrationForm.Profile
  alias RegistrationForm.Account

  describe "Registration with name 'some user' and email 'user@example.com'" do
    setup do
      changeset = Registration.changeset(%Registration{},
      %{"name" => "some user", "email" => "user@example.com"})
      {:ok, %{changeset: changeset}}
    end

    test "creates account and profile", %{changeset: changeset} do
      {:ok, _} = Registration.insert changeset
      assert one_and_only(Profile).name == "some user"
      assert one_and_only(Account).email == "user@example.com"
    end

    test "returns account and profile", %{changeset: changeset} do
      {:ok, %{profile: profile, account: account}} = Registration.insert changeset
      assert profile.name == "some user"
      assert account.email == "user@example.com"
    end
  end

  describe "Registration with name 'some user' and empty email" do
    setup do
      changeset = Registration.changeset(%Registration{},
      %{"name" => "some user", "email" => ""})
      {:ok, %{changeset: changeset}}
    end

    test "does not create account or profile", %{changeset: changeset} do
      {:error, _} = Registration.insert changeset
      assert Repo.all(Profile) == []
      assert Repo.all(Account) == []
    end

    test "returns right errors", %{changeset: changeset} do
      {:error, changeset} = Registration.insert changeset
      assert Keyword.get(changeset.errors, :email) == {"can't be blank", []}
    end

    test "returns Registration", %{changeset: changeset} do
      {:error, changeset} = Registration.insert changeset
      assert changeset.data == %Registration{email: "", name: "some user"}
    end
  end

  describe "Registration with empty name and email 'user@example.com'" do
    setup do
      changeset = Registration.changeset(%Registration{},
      %{"name" => "", "email" => "user@example.com"})
      {:ok, %{changeset: changeset}}
    end

    test "does not create account or profile", %{changeset: changeset} do
      {:error, _} = Registration.insert changeset
      assert Repo.all(Profile) == []
      assert Repo.all(Account) == []
    end

    test "returns right errors", %{changeset: changeset} do
      {:error, changeset} = Registration.insert changeset
      assert Keyword.get(changeset.errors, :name) == {"can't be blank", []}
    end

    test "returns Registration", %{changeset: changeset} do
      {:error, changeset} = Registration.insert changeset
      assert changeset.data == %Registration{email: "user@example.com", name: ""}
    end
  end

  defp one_and_only(module) do
    records = Repo.all(module)
    assert records |> length == 1
    List.first(records)
  end
end
