defmodule RegistrationForm.RegistrationControllerTest do
  use RegistrationForm.ConnCase

  alias RegistrationForm.Registration
  alias RegistrationForm.Profile
  alias RegistrationForm.Account
  @valid_attrs %{name: "some content", email: "user@example.com"}
  @invalid_attrs %{}

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, registration_path(conn, :new)
    assert html_response(conn, 200) =~ "New registration"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, registration_path(conn, :create), registration: @valid_attrs
    assert redirected_to(conn) == registration_path(conn, :new)
    assert Repo.get_by(Account, email: "user@example.com")
    assert Repo.get_by(Profile, name: "some content")
  end
end
