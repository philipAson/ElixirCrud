
defmodule Users do

  @users [
    %{:Id => 115135, :name  => "Bob", :email => "bob@upptec.se", :dateOfBirth => ~D[1972-01-01], :createdAt => ~U[2020-01-12 00:01:00.00Z], :isActive => true},
    %{:Id => 221351, :name  => "Greg", :email => "Greg@upptec.se", :dateOfBirth => ~D[2002-01-01], :createdAt => ~U[2012-01-12 00:01:00.00Z], :isActive => false},
    %{:Id => 335121, :name  => "Sven", :email => "Sven@upptec.se", :dateOfBirth => ~D[2006-01-01], :createdAt => ~U[2013-01-12 00:01:00.00Z], :isActive => true},
    %{:Id => 445215, :name  => "Jan", :email => "Jan@upptec.se", :dateOfBirth => ~D[1986-01-01], :createdAt => ~U[2023-01-12 00:01:00.00Z], :isActive => true},
    %{:Id => 551261, :name  => "Ida", :email => "Ida@upptec.se", :dateOfBirth => ~D[1989-01-01], :createdAt => ~U[2020-01-12 00:01:00.00Z], :isActive => true},
    %{:Id => 663123, :name  => "Mia", :email => "Mia@upptec.se", :dateOfBirth => ~D[1942-01-01], :createdAt => ~U[2010-01-12 00:01:00.00Z], :isActive => false},
    %{:Id => 775195, :name  => "Ulla", :email => "Ulla@upptec.se", :dateOfBirth => ~D[1999-01-01], :createdAt => ~U[2011-01-12 00:01:00.00Z], :isActive => true},
    %{:Id => 885112, :name  => "Hans", :email => "Hans@upptec.se", :dateOfBirth => ~D[1992-01-01], :createdAt => ~U[2018-01-12 00:01:00.00Z], :isActive => false},
    %{:Id => 995123, :name  => "Hilda", :email => "Hilda@upptec.se", :dateOfBirth => ~D[1988-01-01], :createdAt => ~U[2013-01-12 00:01:00.00Z], :isActive => true},
    %{:Id => 101012, :name  => "Nanna", :email => "Nanna@upptec.se", :dateOfBirth => ~D[1963-01-01], :createdAt => ~U[2019-01-12 00:01:00.00Z], :isActive => true}
  ]


  def listUsers do
    Enum.map(@users, fn user ->
      age = getAge(user[:dateOfBirth])
      Map.put(user, :age, age)
    end)
    # @users
    # Enum.join(@users, fn user -> user[:age => getAgeOfUser(user[:id])] == id end)
  end

  def getById(id) do
    Enum.find(@users, fn user -> user[:Id] == id end)
  end

  def getByEmail(email) do
    Enum.find(@users, fn user -> user[:email] == email end)
  end

  def getAgeOfUser(id) do
    user = getById(id)
    getAge(user[:dateOfBirth])
  end

  def getAge(dateOfBirth) do
    div(Date.diff(Date.utc_today(), dateOfBirth), 365)
  end

  def getNumberOfRndUsers(x) do
    if (!is_integer(x) or x <= 0 or x > Enum.count(@users)) do
      {"err invalid input"}
    else
      Enum.take_random(@users, x)
    end
  end

  def filterByStatus(status) do
    Enum.filter(@users, fn user ->
      Map.get(user, :isActive) == status
    end)
  end

  def filterByAge(age) do
    if (!is_integer(age) || age <= 0) do
      {:error, "invalid input"}
    else
      Enum.filter(@users, fn  user ->
        userAge = getAge(user[:dateOfBirth])
        userAge == age
      end)
    end
  end

  def sortByAge do
    Enum.sort(@users, fn user1, user2 ->
      user1[:dateOfBirth] >= user2[:dateOfBirth]
    end)
  end

  def sortByCreated do
    Enum.sort(@users, fn foo, bar ->
      foo[:createdAt] >= bar[:createdAt]
    end)
  end

  def sortByName do
    Enum.sort(@users, fn user1, user2 ->
      user1[:name] <= user2[:name]
    end)
  end

  def filterByEmail(input) do
    Enum.filter(@users, fn user ->
      String.contains?(user[:email], input)
    end)
  end

  @spec getAge(%{
    :calendar => atom(),
    :day => any(),
    :month => any(),
    :year => any(),
    optional(any()) => any()
  }) :: integer()
end
