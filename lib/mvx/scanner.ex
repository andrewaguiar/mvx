defmodule Mvx.Scanner do
  alias Mvx.Colors
  alias Mvx.Term

  def generate(files, term) do
    files
    |> Enum.filter(&(Term.match?(term, &1)))
    |> Enum.with_index(1)
    |> Enum.map(fn {file, id} -> {id, file} end)
  end

  def print(matched_files, term) do
    IO.puts("#{Colors.yellow("ID")} :: #{Colors.green("FILE")}\n")

    matched_files
      |> Enum.each(fn {id, file} ->
        around_text = Term.highlight(term, file)
        IO.puts("#{Colors.yellow(id)} :: #{around_text}")
      end)
  end
end
