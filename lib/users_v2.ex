defmodule UsersV2 do
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
    %{id: 121212, name: "Alfred", email: "Alfred@upptec.se", date_of_birth: ~D[1783-01-01], created_at: ~U[2001-01-12 00:01:00.00Z], is_active: true},
  ]

  def list_users do
    Enum.map(@users, fn user ->
      age = Users.get_age(user.date_of_birth)
      Map.put(user, :age, age)
    end)
  end

  def list_users(limit, filter, sorter) do
    users = list_users()
  end

  def list_users(limit) when is_integer(limit) do
    if (limit <= 0 or limit > Enum.count(@users)) do
      {"err, invalid input(#{limit}). total users = #{Enum.count(@users)}"}
    else
      Enum.take(@users, limit)
    end
  end

  def list_users(sorter) when is_binary(sorter) do
    case sorter do
      "age" -> Enum.sort(@users, fn user1, user2 ->
        user1.date_of_birth >= user2.date_of_birth
      end)
      "name" -> Enum.sort(@users, fn user1, user2 ->
        user1.name <= user2.name
      end)
      "created" -> Enum.sort(@users, fn user1, user2 ->
        user1.created_at >= user2.created_at
      end)
      _ -> {"invalid sorter. choose one(age, name, created)"}
    end
  end
end
