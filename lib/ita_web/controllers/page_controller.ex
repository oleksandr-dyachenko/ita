defmodule ItaWeb.PageController do
  use ItaWeb, :controller
  alias ItaWeb.AutoModel

  def index(conn, _params) do
    top_searches = AutoModel.getTopSearches()
    top_auto = AutoModel.get_random_auto()

    render(conn, "index.html", %{
      top_searches: top_searches,
      top_auto: top_auto
    } |> IO.inspect)
  end

  def contacts(conn, _params) do
    render(conn, "contacts.html")
  end

  def feedback(conn, _params) do
    render(conn, "feedback.html")
  end

  def save_feedback(conn, params) do
    # ? save
    IO.inspect(params)

    redirect(conn, to: "/")
  end

  def auto(conn, params) do
    auto = List.first(ItaWeb.AutoModel.get_auto(params["id"]))
    random_auto = List.first(ItaWeb.AutoModel.get_random_auto())

    render(
      conn,
      "auto.html",
      auto: auto,
      random_auto: random_auto
    )
  end

  def search(conn, params) do
    marks = AutoModel.getMarks()
    autos = AutoModel.search(params)


    render(
      conn,
      "search.html",
      %{
        autos: autos,
        marks: marks,
        params: params
      }
    )
  end
end
