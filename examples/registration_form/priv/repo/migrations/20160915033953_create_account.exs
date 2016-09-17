defmodule RegistrationForm.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :email, :string

      timestamps()
    end

  end
end
