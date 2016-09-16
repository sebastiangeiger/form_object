defmodule RegistrationForm.Registration do
  defstruct name: nil, email: nil
  alias RegistrationForm.Repo
  alias RegistrationForm.Profile
  alias RegistrationForm.Account

  # The method names are chosen to imitate the methods usually found in an ecto
  # model

  def changeset(_struct, params \\ %{}) do
    %{
      account: Account.changeset(%Account{}, %{email: params[:email]}),
      profile: Profile.changeset(%Profile{}, %{name: params[:name]})
    }
  end

  def insert(%{account: account, profile: profile}) do
    multi = Ecto.Multi.new
            |> Ecto.Multi.insert(:account, account)
            |> Ecto.Multi.insert(:profile, profile)

    case Repo.transaction(multi) do
      {:ok, _} -> {:ok, :fake}
      {:error, _, _, _} -> {:error, :fake}
    end
  end
end

