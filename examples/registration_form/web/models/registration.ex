defmodule RegistrationForm.Changeset do
  #TODO: Move the FormObject.Changeset eventually
  defstruct errors: [], data: nil, params: [], action: nil
end

if Code.ensure_loaded?(Phoenix.HTML) do
  defimpl Phoenix.HTML.FormData, for: RegistrationForm.Changeset do
    def input_type(_, _) do
      raise "FormData is only partially implemented"
    end

    def input_validations(_, _) do
      raise "FormData is only partially implemented"
    end

    # Stolen from phoenix_ecto/html.ex
    def to_form(changeset, opts) do
      %{params: params, data: data} = changeset
      {name, opts} = Keyword.pop(opts, :as)
      name = to_string(name || form_for_name(data))

      %Phoenix.HTML.Form{
        source: changeset,
        impl: __MODULE__,
        id: name,
        name: name,
        errors: form_for_errors(changeset),
        data: data,
        params: params || %{},
        hidden: form_for_hidden(data),
        options: Keyword.put_new(opts, :method, "post")
      }
    end

    defp form_for_errors(%{action: nil}), do: []
    defp form_for_errors(%{errors: errors}), do: errors

    defp form_for_name(%{__struct__: module}) do
      module
      |> Module.split()
      |> List.last()
      |> Macro.underscore()
    end
    defp form_for_hidden(_), do: []

    def to_form(_, _, _, _) do
      raise "FormData is only partially implemented"
    end
  end
end

defmodule RegistrationForm.Registration do
  defstruct name: nil, email: nil
  alias RegistrationForm.Repo
  alias RegistrationForm.Profile
  alias RegistrationForm.Account

  # The method names are chosen to imitate the methods usually found in an ecto
  # model

  def changeset(_struct, params \\ %{}) do
    data = %__MODULE__{name: params[:name], email: params[:email]}
    %RegistrationForm.Changeset{data: data, params: params}
  end

  def insert(%RegistrationForm.Changeset{data: data}) do
    account =  Account.changeset(%Account{}, %{email: data.email})
    profile = Profile.changeset(%Profile{}, %{name: data.name})
    multi = Ecto.Multi.new
            |> Ecto.Multi.insert(:account, account)
            |> Ecto.Multi.insert(:profile, profile)

    case Repo.transaction(multi) do
      {:ok, _} -> {:ok, :fake}
      {:error, _, changeset, _} ->
        {:error, %RegistrationForm.Changeset{errors: changeset.errors, data: data}}
    end
  end
end
