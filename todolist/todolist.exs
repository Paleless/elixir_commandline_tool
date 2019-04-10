defmodule Todolist do
  def start do
    IO.gets("Name of .csv to load: ")
    |> String.trim()
    |> read()
    |> parse()
    |> getCommand()
  end

  def getCommand(data) do
    prompt = """
    Type the first letter of the command you want to run
    R)ead Todos     A)dd a Todo     D)elete a Todo  L)oad a .csv S)ave a .csv
    """

    command =
      IO.gets(prompt)
      |> String.trim()
      |> String.downcase()

    case command do
      "r" -> showTodos(data)
      "d" -> deleteTodos(data)
      "q" -> "Goodbye"
      _ -> getCommand(data)
    end
  end

  def deleteTodos(data) do
    todo = IO.gets("Which todo would you like to delete?\n") |> String.trim()

    if Map.has_key?(data, todo) do
      IO.puts("ok.")
      new_map = Map.drop(data, [todo])
      IO.puts("#{todo} has been deleted")
      getCommand(new_map)
    else
      IO.puts("There is no todo named #{todo}")
      showTodos(data, false)
      deleteTodos(data)
    end
  end

  defp read(filename) do
    case File.read(filename) do
      {:ok, content} ->
        content

      {:error, reason} ->
        IO.puts(~s(Colud not open file "#{filename}\n"))
        IO.inspect(reason)
    end
  end

  defp parse(content) do
    [header | lines] = String.split(content, ~r/\r\n|\r|\n/)

    titles =
      header
      |> String.split(",")
      |> tl()

    parseLines(lines, titles)
  end

  defp parseLines(lines, titles) do
    Enum.reduce(lines, %{}, fn line, built ->
      [name | fields] = String.split(line, ",")

      if Enum.count(fields) === Enum.count(titles) do
        line_data = Enum.zip(titles) |> Enum.into(%{})
        Map.merge(built, %{name => line_data})
      else
        built
      end
    end)
  end

  def showTodos(data, next_command? \\ true) do
    items = Map.keys(data)
    IO.puts("You have the following Todos:\n")
    Enum.each(items, fn item -> IO.puts(item) end)
    IO.puts("\n")

    if next_command? do
      getCommand(data)
    end
  end
end

Todolist.start()
