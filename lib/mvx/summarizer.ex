defmodule Mvx.Summarizer do
  alias Mvx.Colors

  def print(matched_files) do
    total_files = matched_files
      |> Enum.map(fn {_, file} -> file end)
      |> Enum.uniq
      |> length

    IO.puts(
      "\n#{Colors.green(total_files)} files found\n"
    )
  end
end
