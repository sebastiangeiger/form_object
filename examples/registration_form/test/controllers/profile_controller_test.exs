defmodule RegistrationForm.ProfileControllerTest do
  use RegistrationForm.ConnCase

  alias RegistrationForm.Profile
  @valid_attrs %{name: "some name"}
  @invalid_attrs %{}

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, profile_path(conn, :new)
    assert html_response(conn, 200) =~ "New profile"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, profile_path(conn, :create), profile: @valid_attrs
    assert redirected_to(conn) == profile_path(conn, :new)
    assert Repo.get_by(Profile, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, profile_path(conn, :create), profile: @invalid_attrs
    assert html_response(conn, 200) =~ "New profile"
  end
end
