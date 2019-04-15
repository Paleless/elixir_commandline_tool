defmodule Deal do
  @moduledoc """
  wc is the same as unix wc
  """
  def wc() do
    IO.gets("input your filename: (h for help)\n")
    |> String.trim()
    |> dealFileName()
  end

  defp dealFileName(filename) do
    case filename do
      "h" ->
        h()

      _ ->
        filename
        |> String.split("-")
        |> dealFile()
    end
  end

  defp dealFile([filename | flags]) do
    case File.read(filename) do
      {:ok, content} ->
        words =
          content
          |> String.split(" ")
          |> Enum.count()

        lines =
          content
          |> String.split("\n")
          |> Enum.count()

        chars =
          content
          |> String.split(~r/(\\n|[^\w])+/)
          |> Enum.join()
          |> String.length()

        Enum.each(flags, fn
          "l" -> IO.puts("Lines: #{lines}")
          "w" -> IO.puts("Words: #{words}")
          "c" -> IO.puts("Characters: #{chars}")
          _ -> nil
        end)

      {:error, _} ->
        IO.puts('Opps!, may be file not exist...')
    end
  end

  @doc """
  show the help info
  """
  defp h do
    IO.puts("""
    Usage: [filename] -[flags]
    Flags: 
    -l display line count
    -c display character count
    -w display word count

    example: somefile.txt -lc
    """)
  end
end

Deal.wc()
