use Mix.Config

config :myApi, MyApi.Guardian,
  issuer: "myApi",
  secret_key: "Secret key. Use `mix guardian.gen.secret` to generate one"
