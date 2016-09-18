defmodule RegistrationForm.RegistrationController do
  use RegistrationForm.Web, :controller

  alias RegistrationForm.Registration

  def new(conn, _params) do
    changeset = Registration.changeset(%Registration{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"registration" => registration_params}) do
    changeset = Registration.changeset(%Registration{}, registration_params)

    case Registration.insert(changeset) do
      {:ok, _registration} ->
        conn
        |> put_flash(:info, "Registration created successfully.")
        |> redirect(to: registration_path(conn, :new))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
