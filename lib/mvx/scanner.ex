defmodule Mvx.Scanner do
  alias Mvx.Colors
  alias Mvx.Term

  def generate(files, term) do
    files
    |> Enum.filter(&(Term.match?(term, &1)))
    |> Enum.with_index(1)
    |> Enum.map(fn {file, id} -> {id, file} end)
  end

  def print(matched_lines, term) do
    IO.puts("#{Colors.yellow("ID")} :: #{Colors.green("FILE")}\n")

    matched_lines
      |> Enum.each(fn {id, file} ->
        around_text = highlight(file, term)
        IO.puts("#{Colors.yellow(id)} :: #{around_text}")
      end)
  end

  defp highlight(line, term) do
    Term.highlight(term, line)
  end
end
