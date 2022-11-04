defmodule Mvx.Replacer do
  alias Mvx.Term

  def run(matched_files, term, replacement, conditions) do
    matched_files
      |> Enum.filter(fn {id, _} -> apply_replacement?(id, conditions) end)
      |> Enum.map(fn {_, file} ->
        new_file = Term.replace(term, file, replacement)

        if File.dir?(file) do
          File.mkdir_p(new_file)
        else
          create_basepath(new_file)

          File.rename(file, new_file)
        end
      end)

    IO.puts("Done")
  end

  defp create_basepath(new_file) do
    parts = Path.split(new_file)

    {basepath, _} = Enum.split(parts, Enum.count(parts) - 1)

    folder = Path.join(basepath)

    if !File.exists?(folder) do
      File.mkdir_p(folder)
    end
  end

  defp apply_replacement?(id, conditions) do
    Enum.member?(conditions, "a") || Enum.member?(conditions, id)
  end
end
