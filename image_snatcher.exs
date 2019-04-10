defmodule ImageSnatcher do
  def start do
    File.mkdir("images")
    matcher = ~r/\.(jpg|jpeg|gif|png|bmp)$/

    File.ls!()
    |> Enum.filter(&Regex.match?(matcher, &1))
    |> Enum.each(fn filename ->
      case File.rename(filename, "./images/#{filename}") do
        {:ok, _} ->
          IO.puts("file moved")

        {:error, info} ->
          IO.puts("can't move #{filename}. Does it exist?")
          IO.inspect(info)
      end
    end)
  end
end

ImageSnatcher.start()
