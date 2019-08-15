defmodule MyApiWeb.SessionView do
  use MyApiWeb, :view
  alias MyApiWeb.SessionView

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end
end
