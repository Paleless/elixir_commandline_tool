defmodule Tail do
  @moduledoc """
  this is a elixir module implements the function same as unix tail
  """
  def start() do
    IO.gets("please input the filename")
    |> String.split(~r/\s+/, trim: true)
    |> deal()

    # get filename and options
    # print last 10 lines
  end

  def deal([filename | flags]) do
    case filename do
      "h" -> show_help()
      _ -> dealFile(filename, flags)
    end
  end

  defp dealFile(filename, flags) do
    case File.read(filename) do
      {:ok, content} ->
        content
        |> String.split(~r/\r|\n|\r\n/)
        |> Enum.with_index()
        |> Enum.take(-10)
        |> Enum.each(fn {text, index} -> IO.puts("#{index} #{text}") end)

      {:error, _} ->
        IO.puts("this is file may be not exist???")
        start()
    end
  end

  defp show_help() do
    IO.puts("""
    h) for help
    """)
  end
end
