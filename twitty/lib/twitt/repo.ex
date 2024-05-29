defmodule Twitt.Repo do
  use Ecto.Repo,
    otp_app: :twitt,
    adapter: Ecto.Adapters.Postgres
end
