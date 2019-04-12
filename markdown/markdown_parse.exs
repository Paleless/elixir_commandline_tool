defmodule MarkdownParse do
  def start() do
    filename =
      IO.gets("please input the .md file to convert\n")
      |> String.trim()

    filename
    |> read()
    |> parse()
    |> save(filename)
  end

  @doc """
  read the file
  """
  def read(filename) do
    case File.read(filename) do
      {:ok, body} ->
        body

      {:error, info} ->
        IO.puts("oops! does it exist? try again.\n")
        IO.inspect(info)
        start()
    end
  end

  @doc """
  split the content by line and then parse line into html
  at last join tegother and return 
  """
  def parse(body) do
    body
    |> String.split(~r/\r|\n|\r\n/, trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.join("\n")
  end

  @doc """
  match the md rule and convert to html
  """
  def parse_line(line) do
    case Regex.run(~r/^(#|##|###|####|#####|######|-)\s(.*)/, line) do
      [_, "#", content] -> "<h1>" <> content <> "</h1>"
      [_, "##", content] -> "<h2>" <> content <> "</h2>"
      [_, "###", content] -> "<h3>" <> content <> "</h3>"
      [_, "####", content] -> "<h4>" <> content <> "</h4>"
      [_, "#####", content] -> "<h5>" <> content <> "</h5>"
      [_, "######", content] -> "<h6>" <> content <> "</h6>"
      [_, "-", content] -> "<li>" <> content <> "</li>"
      [_, ">", content] -> "<li>" <> content <> "</li>"
      [_, "---", content] -> "<br/>"
      [_, "***", content] -> "<br/>"
      _ -> line
    end
  end

  def save(content, filename) do
    new_filename = String.replace(filename, ~r/\..*$/, ".html")

    case File.write(new_filename, content) do
      :ok ->
        IO.puts("file convert successful!")

      {:error, info} ->
        IO.puts("save failed")
        IO.inspect(info)
    end
  end

  def p(c) do
    String.replace(c, ~r/(\r\n|\r|\n)(.*)\1/, "<p>\\1</p>")
  end

  def italics(c) do
    String.replace(c, ~r/[^\*]*\*(.*)\*[^\*]*/, "<em>\\1</em>")
  end

  def bold(c) do
    String.replace(c, ~r/\*\*(.*)\*\*/, "<strong>\\1</strong>")
  end

  def h1(c) do
    String.replace(c, ~r/#\s+(.*)/, "<h1>\\1</h1>")
  end

  def h2(c) do
    String.replace(c, ~r/#{2}\s+(.*)/, "<h2>\\1</h2>")
  end

  def h3(c) do
    String.replace(c, ~r/#{3}\s+(.*)/, "<h3>\\1</h3>")
  end

  def h4(c) do
    String.replace(c, ~r/#{4}\s+(.*)/, "<h4>\\1</h4>")
  end

  def h5(c) do
    String.replace(c, ~r/#{5}\s+(.*)/, "<h5>\\1</h5>")
  end

  def h6(c) do
    String.replace(c, ~r/#{6}\s+(.*)/, "<h6>\\1</h6>")
  end
end
