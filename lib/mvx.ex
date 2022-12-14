defmodule Mvx do
  alias Mvx.Colors
  alias Mvx.ConditionsParser
  alias Mvx.Replacer
  alias Mvx.Scanner
  alias Mvx.Summarizer
  alias Mvx.Searcher

  def run(args_config, term_string, replacement) do
    term = %Mvx.Term{value: term_string, regex: args_config[:regex] != nil}

    all_files = Searcher.find(args_config[:filename])

    matched_files = Scanner.generate(all_files, term)

    Scanner.print(matched_files, term)

    Summarizer.print(matched_files)

    if replacement do
      run_replacer(matched_files, term, replacement)
    end
  end

  defp run_replacer([], _, _) do
    IO.puts("No occurrences found")
  end

  defp run_replacer(matched_files, term, replacement) do
    IO.puts("Instructions:")
    IO.puts("  Type an \"#{Colors.green("a")}\" to replace all.")
    IO.puts("  Type a single #{Colors.yellow("ID")} number to replace only that line. example #{Colors.yellow("1")}")
    IO.puts("  Type a set of #{Colors.yellow("IDs")} separated by comma, example: #{Colors.yellow("1,2,3")}.")
    IO.puts("  Type an inclusive range using .. to replace a range of IDs, example: #{Colors.yellow("3..5")} same as to #{Colors.yellow("3,4,5")}")
    IO.puts("  Conbine #{Colors.yellow("IDs")} and Ranges freely. example: #{Colors.yellow("1,2,3,10..12,20..25")}")
    IO.puts("  Type nothing and press Enter to abort\n")

    case IO.gets("Which files do you want to replace? ") do
      "\n" ->
        IO.puts("\nAborting!")

      conditions ->
        IO.puts("")

        parsed_conditions = ConditionsParser.parse(conditions)
        Replacer.run(matched_files, term, replacement, parsed_conditions)
    end
  end
end
