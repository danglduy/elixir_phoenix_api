defmodule MyApi.Guardian do
  use Guardian, otp_app: :myApi

  def subject_for_token(user, _claims) when is_map(user) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims) when is_map(claims) do
    id = claims["sub"]
    resource = MyApi.Accounts.get_user!(id)
    {:ok, resource}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
