defmodule MarkdownParse do
  def start() do
    filename =
      IO.gets("please input the .md file to convert\n")
      |> String.trim()

    filename
    |> read()
    |> parse()
    |> save(filename)

    # read the file
    # parse the file to html
    ## split content into lines and parse lines for rules like (# ## ### > --- ***)
    ## split line into words and parse word for rules like (`` **)
    # save the file
  end

  def read(filename) do
    case File.read(filename) do
      {:ok, body} ->
        body

      {:error, info} ->
        IO.puts("oops! does it exist?")
        IO.inspect(info)
    end
  end

  def parse(body) do
    body
  end

  def to_html(text) do
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
end

MarkdownParse.start()
