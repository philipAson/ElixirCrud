
defmodule Users do

  # @users [
  #   %{:Id => 115135, :name  => "Bob", :email => "bob@upptec.se", :date_of_birth => ~D[1972-01-01], :createdAt => ~U[2020-01-12 00:01:00.00Z], :is_active => true},
  #   %{:Id => 221351, :name  => "Greg", :email => "Greg@upptec.se", :date_of_birth => ~D[2002-01-01], :createdAt => ~U[2012-01-12 00:01:00.00Z], :is_active => false},
  #   %{:Id => 335121, :name  => "Sven", :email => "Sven@upptec.se", :date_of_birth => ~D[2006-01-01], :createdAt => ~U[2013-01-12 00:01:00.00Z], :is_active => true},
  #   %{:Id => 445215, :name  => "Jan", :email => "Jan@upptec.se", :date_of_birth => ~D[1986-01-01], :createdAt => ~U[2023-01-12 00:01:00.00Z], :is_active => true},
  #   %{:Id => 551261, :name  => "Ida", :email => "Ida@upptec.se", :date_of_birth => ~D[1989-01-01], :createdAt => ~U[2020-01-12 00:01:00.00Z], :is_active => true},
  #   %{:Id => 663123, :name  => "Mia", :email => "Mia@upptec.se", :date_of_birth => ~D[1942-01-01], :createdAt => ~U[2010-01-12 00:01:00.00Z], :is_active => false},
  #   %{:Id => 775195, :name  => "Ulla", :email => "Ulla@upptec.se", :date_of_birth => ~D[1999-01-01], :createdAt => ~U[2011-01-12 00:01:00.00Z], :is_active => true},
  #   %{:Id => 885112, :name  => "Hans", :email => "Hans@upptec.se", :date_of_birth => ~D[1992-01-01], :createdAt => ~U[2018-01-12 00:01:00.00Z], :is_active => false},
  #   %{:Id => 995123, :name  => "Hilda", :email => "Hilda@upptec.se", :date_of_birth => ~D[1988-01-01], :createdAt => ~U[2013-01-12 00:01:00.00Z], :is_active => true},
  #   %{:Id => 101012, :name  => "Nanna", :email => "Nanna@upptec.se", :date_of_birth => ~D[1963-01-01], :createdAt => ~U[2019-01-12 00:01:00.00Z], :is_active => true}
  # ]

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
    %{id: 101012, name: "Nanna", email: "Nanna@upptec.se", date_of_birth: ~D[1963-01-01], created_at: ~U[2019-01-12 00:01:00.00Z], is_active: true}
  ]



  def list_users do
    Enum.map(@users, fn user ->
      age = get_age(user[:date_of_birth])
      Map.put(user, :age, age)
    end)
  end

  def list_users(limit) when is_integer(limit) do
    get_x_rnd_users(limit)
  end

  def list_users(sort_by) when(is_binary(sort_by)) do
    case sort_by do
      "age" -> sort_by_age()
      "created_at" -> sort_by_created()
      "name" -> sort_by_name()
      _ -> IO.puts("invalid input. options:(age, created_at, name)")

    end
  end

  def get_by_id(id) when is_integer(id) do
    Enum.find(@users, fn user -> user[:id] == id end)
  end

  def get_by_id(id) do
    {:error, "Receieved invalid input: #{id}"}
  end

  def get_by_email(email) do
    Enum.find(@users, fn user -> user[:email] == email end)
  end
#felhantering
  def get_age_of_user(id) do
    user = get_by_id(id)
    get_age(user[:date_of_birth])
  end

  def get_age(date_of_birth) do
    div(Date.diff(Date.utc_today(), date_of_birth), 365)
  end

  def get_x_rnd_users(x) do
    if (!is_integer(x) or x <= 0 or x > Enum.count(@users)) do
      {"err invalid input"}
    else
      Enum.take_random(@users, x)
    end
  end

  @spec filter_by_status(boolean()) :: list()
  def filter_by_status(status) when is_boolean(status) do
    Enum.filter(@users, fn user ->
      Map.get(user, :is_active) == status
    end)
  end

  def filter_by_status(something_else) do
    {"err, invalid input(#{something_else}). insert a boolean value"}
  end

  def filter_by_age(age) when is_integer(age) do
    if (!is_integer(age) || age <= 0) do
      {:error, "invalid input"}
    else
      Enum.filter(@users, fn  user ->
        user_age = get_age(user[:date_of_birth])
        user_age == age
      end)
    end
  end

  def filter_by_age(age) when is_binary(age) do
    case Integer.parse(age) do
      {intAge, _} -> filter_by_age(intAge)
      :error -> {:error, "..."}
    end
  end

  @spec sort_by_age() :: list()
  def sort_by_age do
    Enum.sort(@users, fn user1, user2 ->
      user1[:date_of_birth] >= user2[:date_of_birth]
    end)
  end

  def sort_by_created do
    Enum.sort(@users, fn foo, bar ->
      foo[:created_at] >= bar[:created_at]
    end)
  end

  def sort_by_name do
    Enum.sort(@users, fn user1, user2 ->
      user1[:name] <= user2[:name]
    end)
  end

  def filter_by_email(input) do
    if (is_binary(input)) do
      Enum.filter(@users, fn user ->
        String.contains?(user[:email], input)
      end)
    else
      {"fart"}
    end
  end
end
