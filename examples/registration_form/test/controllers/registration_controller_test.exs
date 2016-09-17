defmodule RegistrationForm.RegistrationControllerTest do
  use RegistrationForm.ConnCase

  alias RegistrationForm.Registration
  @valid_attrs %{name: "some content", email: "user@example.com"}
  @invalid_attrs %{}

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, registration_path(conn, :new)
    assert html_response(conn, 200) =~ "New registration"
  end
end
