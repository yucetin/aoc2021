defmodule Day01 do
  def run(), do: run(input())
  def run([_ | []]), do: 0
  def run([first | second]) when hd(second) > first, do: 1 + run(second)
  def run([first | second]), do: run(second)

  def input() do
    "lib/inputs/01.input"
    |> File.read!()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end
end
