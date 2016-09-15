defmodule RegistrationForm.ProfileTest do
  use RegistrationForm.ModelCase

  alias RegistrationForm.Profile

  test "Profile with name 'some user' is valid" do
    changeset = Profile.changeset(%Profile{}, %{name: "some user"})
    assert changeset.valid?
  end

  test "Can create an profile in the database" do
    assert Repo.all(Profile) == []
    changeset = Profile.changeset(%Profile{}, %{name: "some user"})
    Repo.insert! changeset
    assert Repo.all(Profile) |> Enum.count == 1
  end

  test "Cannot create an profile with a blank name" do
    changeset = Profile.changeset(%Profile{}, %{name: ""})
    refute changeset.valid?
    assert Keyword.get(changeset.errors, :name) == {"can't be blank", []}
  end
end
