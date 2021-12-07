defmodule Day05 do
  def run() do
    input()
    |> gen_board(%{})
    |> Enum.filter(fn {x, y} -> y > 2 end)
    |> length
  end

  def gen_board([head | rest], map) do
    [x1, y1, x2, y2] = Enum.map(head, &String.to_integer/1)

    list_of_keys =
      for i <- x1..x2,
          j <- y1..y2,
          do: "#{i},#{j}"

    updated_map =
      Enum.reduce(list_of_keys, map, fn key, acc ->
        Map.update(acc, key, 0, fn value -> value + 1 end)
      end)

    gen_board(rest, updated_map)
  end

  def gen_board([], map), do: map

  defp input() do
    "lib/inputs/05.input"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn str -> String.replace(str, " -> ", ",") end)
    |> Enum.map(fn str -> String.split(str, ",") end)
  end
end
