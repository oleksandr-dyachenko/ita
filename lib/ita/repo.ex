defmodule Ita.Repo do
  use Ecto.Repo,
    otp_app: :ita,
    adapter: Ecto.Adapters.MySQL
end
