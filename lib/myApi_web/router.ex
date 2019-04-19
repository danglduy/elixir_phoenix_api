defmodule MyApiWeb.Router do
  use MyApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", MyApiWeb do
    pipe_through :api

    post "sign_up", UserController, :create
  end
end
