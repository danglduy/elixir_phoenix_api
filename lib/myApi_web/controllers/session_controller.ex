defmodule MyApiWeb.SessionController do
  use MyApiWeb, :controller

  alias MyApi.Accounts

  action_fallback MyApiWeb.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do
    case Accounts.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", jwt: token)

      _ ->
        {:error, :unauthorized}
    end
  end
end
