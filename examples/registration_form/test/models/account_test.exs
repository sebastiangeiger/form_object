defmodule RegistrationForm.AccountTest do
  use RegistrationForm.ModelCase

  alias RegistrationForm.Account

  test "Account with email 'user@example.com' is valid" do
    changeset = Account.changeset(%Account{}, %{email: "user@example.com"})
    assert changeset.valid?
  end

  test "Can create an account in the database" do
    assert Repo.all(Account) == []
    changeset = Account.changeset(%Account{}, %{email: "user@example.com"})
    Repo.insert! changeset
    assert Repo.all(Account) |> Enum.count == 1
  end

  test "Cannot create an account with a blank email" do
    changeset = Account.changeset(%Account{}, %{email: ""})
    refute changeset.valid?
  end
end
