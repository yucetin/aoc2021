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

    [oxy] = filter(input, freq(input, "oxy"), 0, "oxy")
    [co2] = filter(input, freq(input, "co2"), 0, "co2")
    oxy = Enum.join(oxy) |> String.to_integer(2) |> IO.inspect()
    co2 = Enum.join(co2) |> String.to_integer(2) |> IO.inspect()
    oxy * co2
  end

  defp freq(input, source) do
    Enum.zip(input)
    |> Enum.map(fn tuple -> Tuple.to_list(tuple) end)
    |> Enum.map(fn tuple -> Enum.frequencies(tuple) end)
    |> source(source)
  end

  defp source(list, "oxy") do
    Enum.map(list, fn freq ->
      case freq do
        %{"0" => x, "1" => y} ->
          if y >= x do
            "1"
          else
            "0"
          end

        %{"0" => x} ->
          "0"

        %{"1" => x} ->
          "1"
      end
    end)
  end

  defp source(list, "co2") do
    Enum.map(list, fn freq ->
      case freq do
        %{"0" => x, "1" => y} ->
          if x <= y do
            "0"
          else
            "1"
          end

        %{"0" => x} ->
          "1"

        %{"1" => x} ->
          "0"
      end
    end)
  end

  defp filter([], _, _, _), do: "fuu"
  defp filter(list, _, _, _) when length(list) == 1, do: list |> IO.inspect()

  defp filter(input, freq, start, source) do
    new_input =
      Enum.filter(input, fn x ->
        Enum.at(x, start) ==
          Enum.at(freq, start)
      end)

    new_freq = freq(new_input, source)

    filter(new_input, new_freq, start + 1, source)
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
      String.split(string, "", trim: true)
    end)
  end
end
