defmodule Mvx.Term do
  alias Mvx.Colors

  defstruct [:value, :regex]

  def match?(%Mvx.Term{value: term_string, regex: false}, file) do
    file =~ term_string
  end

  def match?(%Mvx.Term{value: term_string, regex: true}, file) do
    term_string |> Regex.compile! |> Regex.match?(file)
  end

  def highlight(%Mvx.Term{value: term_string, regex: false}, file) do
    String.replace(file, term_string, Colors.red(term_string))
  end

  def highlight(%Mvx.Term{value: term_string, regex: true}, file) do
    term_string |> Regex.compile! |> Regex.replace(file, fn x -> Colors.red(x) end)
  end

  def replace(%Mvx.Term{value: term_string, regex: false}, file, replacement) do
    String.replace(file, term_string, replacement, global: true)
  end

  def replace(%Mvx.Term{value: term_string, regex: true}, file, replacement) do
    String.replace(file, term_string, replacement, global: true)

    term_string |> Regex.compile! |> Regex.replace(file, replacement)
  end
end
