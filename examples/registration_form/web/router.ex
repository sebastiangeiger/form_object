defmodule RegistrationForm.Router do
  use RegistrationForm.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RegistrationForm do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/registrations", RegistrationController, only: [:new, :create]
    resources "/profiles", ProfileController, only: [:new, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", RegistrationForm do
  #   pipe_through :api
  # end
end
