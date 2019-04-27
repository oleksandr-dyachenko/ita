defmodule ItaWeb.AutoModel do
  defp query(query, params \\ []) do
    case Ita.Repo.query(query, params) do
      {
        :ok,
        %Mariaex.Result{
          columns: columns,
          rows: rows
        }
      } ->
        rows
        |> Enum.map(
          &(columns
            |> Enum.zip(&1)
            |> Map.new())
        )

      _ ->
        nil
    end
  end

  def get_auto(id) do
    query(
      "SELECT *,
        marks.name AS marka,
        models.name AS model,
        users.name AS user
      FROM auto
      JOIN marks USING (mark_id)
      JOIN models USING (model_id)
      JOIN users USING (user_id)
      WHERE auto_id = ?",
      [id]
    )
  end

  def get_random_auto(limit \\ 1) do
    query("SELECT *,
        marks.name AS marka,
        models.name AS model,
        users.name AS user
      FROM auto
      JOIN marks USING (mark_id)
      JOIN models USING (model_id)
      JOIN users USING (user_id)
      ORDER BY RAND()
      LIMIT ?", [limit])
  end

  def getMarks() do
    query("select * from marks inner join auto using(mark_id) group by mark_id")
  end
  
  def search(%{
    "text" => text, 
    "mark_id" => mark_id, 
    "price_from" => price_from, 
    "price_till" => price_till
  }) do
    query(
      "SELECT *,
        marks.name AS marka,
        models.name AS model,
        users.name AS user
      FROM auto
      JOIN marks USING (mark_id)
      JOIN models USING (mark_id, model_id)
      JOIN users USING (user_id)
      WHERE (marks.name=? or models.name=? or version like '%#{text}%')
      and mark_id=?
      and price between ? and ?
      ORDER BY RAND()
      LIMIT 10",
      [
        text, 
        text, 
        mark_id, 
        price_from, 
        case price_till do
          "" -> 100_000_000
          price_till -> price_till
        end
      ]
    )
  end

  def search(_) do
    query("SELECT *,
        marks.name AS marka,
        models.name AS model,
        users.name AS user
      FROM auto
      JOIN marks USING (mark_id)
      JOIN models USING (model_id)
      JOIN users USING (user_id)
      ORDER BY RAND()
      LIMIT 10")
  end
 
  def getTopSearches() do
    query(
      "select 
        *,
        marks.name AS mark_name,
        models.name AS model_name,
        count(*) AS cnt
      from auto
      join marks using(mark_id)
      join models using(mark_id, model_id)
      group by model_id
      order by cnt desc
      limit 12"
    )
  end

end
