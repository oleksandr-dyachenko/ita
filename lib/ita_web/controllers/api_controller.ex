defmodule ItaWeb.ApiController do
  use ItaWeb, :controller

  def test(conn, params) do
    json(
      conn,
      %{
        test: [true, false, :unknown],
        now: DateTime.utc_now(),
        one: 1
      }
    )
  end
end
