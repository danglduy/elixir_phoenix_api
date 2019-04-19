defmodule MyApiWeb.Router do
  use MyApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", MyApiWeb do
    pipe_through :api

    resources "/users", UserController, only: [:create, :show]
  end
end
