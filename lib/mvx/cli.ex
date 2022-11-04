defmodule Mvx.CLI do
  alias Mvx.Colors

  def main(args) do
    args |> parse_args |> run
  end

  defp run({args_config, [term, replacement], []}) do
    Mvx.run(args_config, term, replacement)
  end

  defp run({args_config, [term], []}) do
    Mvx.run(args_config, term, nil)
  end

  defp run(_) do
    IO.puts(
      """
      #{Colors.bold("NAME")}
             mvx -- simple and powerfull folder / file name replacer based on non gitignore files

      #{Colors.bold("SYNOPSIS")}
             mvx <string-to-be-replaced> [replacement] [-r]

      #{Colors.bold("DESCRIPTION")}

             Mvx scans all git ls-files recursively and shows all occurences of <string-to-be-replaced> in each file or folder name,
             then it asks for confirmation before replace all occurrences by <replacement>.

             The following options are available:

             #{Colors.bold("--filename | -f")}
                    Filters by absolute path name in any part (defaults '').

                    Example: "mvx AppController ApplicationController -f controllers" will consider only files with controllers
                             in absolute path like ("app/controllers/app_controllers.rb", "config/controllers.rb").

             #{Colors.bold("--regex | -r")}
                    Treats the <string-to-be-replaced> as a regex instead of a simple text (default false).
      """
    )
  end

  defp parse_args(args) do
    switches = [regex: :boolean]
    aliases = [r: :regex, f: :filename]

    OptionParser.parse(args, switches: switches, aliases: aliases)
  end
end
