defmodule RegistrationForm.ProfileController do
  use RegistrationForm.Web, :controller

  alias RegistrationForm.Profile

  def new(conn, _params) do
    changeset = Profile.changeset(%Profile{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"profile" => profile_params}) do
    changeset = Profile.changeset(%Profile{}, profile_params)

    case Repo.insert(changeset) do
      {:ok, _profile} ->
        conn
        |> put_flash(:info, "Profile created successfully.")
        |> redirect(to: profile_path(conn, :new))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
