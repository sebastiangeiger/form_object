defmodule RegistrationForm.Registration do
  defstruct name: nil, email: nil
  alias RegistrationForm.Repo
  alias RegistrationForm.Profile
  alias RegistrationForm.Account

  # The method names are chosen to imitate the methods usually found in an ecto
  # model

  def changeset(_struct, params \\ %{}) do
    %{
      account: %Account{email: params[:email]},
      profile: %Profile{name: params[:name]}
    }
  end

  def insert(%{account: account, profile: profile}) do
    Repo.insert! account
    Repo.insert! profile
    {:ok, :fake}
  end
end

