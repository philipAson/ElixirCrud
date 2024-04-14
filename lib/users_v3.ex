defmodule UsersV3 do
  @users [
    %{id: 115135, name: "Bob", email: "bob@upptec.se", date_of_birth: ~D[1972-01-01], created_at: ~U[2020-01-12 00:01:00.00Z], is_active: true},
    %{id: 221351, name: "Greg", email: "Greg@upptec.se", date_of_birth: ~D[2002-01-01], created_at: ~U[2012-01-12 00:01:00.00Z], is_active: false},
    %{id: 335121, name: "Sven", email: "Sven@upptec.se", date_of_birth: ~D[2006-01-01], created_at: ~U[2013-01-12 00:01:00.00Z], is_active: true},
    %{id: 445215, name: "Jan", email: "Jan@upptec.se", date_of_birth: ~D[1986-01-01], created_at: ~U[2023-01-12 00:01:00.00Z], is_active: true},
    %{id: 551261, name: "Ida", email: "Ida@upptec.se", date_of_birth: ~D[1989-01-01], created_at: ~U[2020-01-12 00:01:00.00Z], is_active: true},
    %{id: 663123, name: "Mia", email: "Mia@upptec.se", date_of_birth: ~D[1942-01-01], created_at: ~U[2010-01-12 00:01:00.00Z], is_active: false},
    %{id: 775195, name: "Ulla", email: "Ulla@upptec.se", date_of_birth: ~D[1999-01-01], created_at: ~U[2011-01-12 00:01:00.00Z], is_active: true},
    %{id: 885112, name: "Hans", email: "Hans@upptec.se", date_of_birth: ~D[1992-01-01], created_at: ~U[2018-01-12 00:01:00.00Z], is_active: false},
    %{id: 995123, name: "Hilda", email: "Hilda@upptec.se", date_of_birth: ~D[1988-01-01], created_at: ~U[2013-01-12 00:01:00.00Z], is_active: true},
    %{id: 101012, name: "Nanna", email: "Nanna@upptec.se", date_of_birth: ~D[1963-01-01], created_at: ~U[2019-01-12 00:01:00.00Z], is_active: true},
    %{id: 111112, name: "Krösa-Majja", email: "Krösa-Majja@upptec.se", date_of_birth: ~D[1721-01-01], created_at: ~U[2000-01-12 00:01:00.00Z], is_active: true},
    %{id: 121212, name: "Arthur", email: "Arthur@upptec.se", date_of_birth: ~D[1581-01-01], created_at: ~U[1992-01-12 00:01:00.00Z], is_active: true},
    %{id: 121212, name: "Fred", email: "Fred@upptec.se", date_of_birth: ~D[1383-01-01], created_at: ~U[2021-01-12 00:01:00.00Z], is_active: true},
    %{id: 121212, name: "Silja", email: "Silja@upptec.se", date_of_birth: ~D[1183-01-01], created_at: ~U[2011-01-12 00:01:00.00Z], is_active: true},
  ]

  
  def list_users(options \\ []) do
    @users
    |> apply_filters(Keyword.get(options, :filter, nil))
    |> sort_users(Keyword.get(options, :sort_by, nil))
    |> limit_users(Keyword.get(options, :limit, length(@users)))
  end

  defp apply_filters(users, nil), do: users
  defp apply_filters(users, filters) do
    Enum.filter(users, fn user ->
      Enum.all?(filters, fn {key, value} ->
        Map.get(user, key) == value
      end)
    end)
  end

  defp sort_users(users, nil), do: users
  defp sort_users(users, sort_by) do
    Enum.sort_by(users, &Map.get(&1, sort_by))
  end

  defp limit_users(users, limit), do: Enum.take(users, limit)

  # UserV3.list_user(limit: x, filter: [is_active: false], sort_by: :name)

end
