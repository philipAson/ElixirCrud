defmodule UsersV4 do
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
    %{id: 121222, name: "Arthur", email: "Arthur@upptec.se", date_of_birth: ~D[1581-01-01], created_at: ~U[1992-01-12 00:01:00.00Z], is_active: true},
    %{id: 131552, name: "Fred", email: "Fred@upptec.se", date_of_birth: ~D[1383-01-01], created_at: ~U[2021-01-12 00:01:00.00Z], is_active: true},
    %{id: 141267, name: "Karro", email: "Karro@upptec.se", date_of_birth: ~D[1973-01-01], created_at: ~U[1993-01-12 00:01:00.00Z], is_active: false},
    %{id: 151256, name: "Hugo", email: "Hugo@upptec.se", date_of_birth: ~D[1984-01-01], created_at: ~U[2011-01-12 00:01:00.00Z], is_active: true},
    %{id: 161899, name: "Vera", email: "Vera@upptec.se", date_of_birth: ~D[1988-01-01], created_at: ~U[2011-01-12 00:01:00.00Z], is_active: false},
  ]

  def list_users(options \\ []) do
    Enum.map(@users, fn user ->
      age = Users.get_age(user.date_of_birth)
      Map.put(user, :age, age)
    end)
    # --- PIPE OPERATOR ---
    |> filter_users(Keyword.get(options, :filter, nil))
    # ~~~ pipes returns of filter_users -> limit_users() ~~~
    |> limit_users(Keyword.get(options, :limit, length(@users)))
    # ~~~ pipes returns of limit_users() -> sort_by() ~~~
    |> sort_users(Keyword.get(options, :sort_by, nil))

  end

  # --- FILt3rzz ---
  defp filter_users(users, nil), do: users
  defp filter_users(users, filters) do
    Enum.reduce(filters, users, fn {filter_key, filter_value}, acc ->
      apply_filter(acc, filter_key, filter_value)
    end)
  end

  defp apply_filter(users, :age, value) do
    Enum.filter(users, fn user -> user.age == value end)
  end
  defp apply_filter(users, :email, value) do
    Enum.filter(users, fn user -> String.contains?(user.email, value) end)
  end
  defp apply_filter(users, :status, value) do
    Enum.filter(users, fn user -> user.is_active == value end)
  end

  # --- Limiter ---
  defp limit_users(users, limit), do: Enum.take(users, limit)

  # --- Sorter ---
  defp sort_users(users, nil), do: users
  defp sort_users(users, sorter) do
    Enum.sort_by(users, &Map.get(&1, sorter))
  end
end
