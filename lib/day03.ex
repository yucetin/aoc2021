defmodule Day03 do
  def run1() do
    input = input1()

    length = String.length(input)

    first = String.to_integer(input, 2)

    sum =
      String.duplicate("1", length)
      |> String.to_integer(2)

    second = sum - first

    first * second
  end

  def run2() do
    input = input2()

    freq_template =
      input
      |> Enum.zip()
      |> Enum.map(fn tuple -> Tuple.to_list(tuple) end)
      |> Enum.map(fn tuple -> Enum.frequencies(tuple) end)
      |> Enum.map(fn %{0 => x, 1 => y} ->
        if x > y do
          0
        else
          1
        end
      end)

    filter(input, freq_template, 0)
  end

  defp filter(list, _, _) when length(list) < 2, do: list

  defp filter(input, freq_template, start) do
    Enum.filter(input, fn x ->
      Enum.at(x, start) ==
        Enum.at(freq_template, start)
    end)
    |> filter(freq_template, start + 1)

    # ^^ failing left to right filter candidate expected values already filtered out
  end

  defp input1() do
    "lib/inputs/03.input"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn string -> String.split(string, "", trim: true) end)
    |> Enum.zip()
    |> Enum.map(fn tuple -> Tuple.to_list(tuple) end)
    |> Enum.map(fn tuple -> Enum.frequencies(tuple) end)
    |> Enum.map(fn map ->
      if map["0"] > map["1"] do
        "0"
      else
        "1"
      end
    end)
    |> Enum.join()
  end

  defp input2() do
    "lib/inputs/03.input"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn string ->
      String.split(string, "", trim: true) |> Enum.map(&String.to_integer/1)
    end)
  end
end
