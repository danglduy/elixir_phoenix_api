defmodule MyApiWeb.SessionView do
  use MyApiWeb, :view

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end
end
