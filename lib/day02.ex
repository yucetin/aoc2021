defmodule Day02 do
  def run() do
    input()
    |> engine()
  end

  defp engine(list), do: engine(list, 0, 0)
  defp engine([["f", vector] | tail], x, y), do: engine(tail, x + vector, y)
  defp engine([["d", vector] | tail], x, y), do: engine(tail, x, y - vector)
  defp engine([["u", vector] | tail], x, y), do: engine(tail, x, y + vector)
  defp engine([], x, y), do: x * abs(y)

  def run2 do
    input()
    |> aimengine()
  end

  defp aimengine(list), do: aimengine(list, 0, 0, 0)
  defp aimengine([["d", vector] | tail], a, x, y), do: aimengine(tail, a + vector, x, y)
  defp aimengine([["u", vector] | tail], a, x, y), do: aimengine(tail, a - vector, x, y)

  defp aimengine([["f", vector] | tail], a, x, y),
    do: aimengine(tail, a, x + vector, y + vector * a)

  defp aimengine([], _a, x, y), do: x * abs(y)

  defp input() do
    "lib/inputs/02.input"
    |> File.read!()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn str -> [String.first(str), String.last(str) |> String.to_integer()] end)
  end
end
