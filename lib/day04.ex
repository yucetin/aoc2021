defmodule Day04 do
  def run do
    [nums | boards] = input()

    nums = String.split(nums, ",", trim: true)
    vertical_boards = vertical_board_gen(boards)
    horizontal_boards = horizontal_board_gen(boards)
    draw(nums, horizontal_boards, vertical_boards)
  end

  defp draw([first | rest], horizontal_boards, vertical_boards) do
    new_horizon = rotate_board(first, horizontal_boards)
    new_vertical = rotate_board(first, vertical_boards)

    draw(rest, new_horizon, new_vertical)
  end

  defp rotate_board(first, board) do
    board
    |> Enum.map(fn set ->
      Enum.map(set, fn line ->
        if line == [first] do
          sum =
            List.flatten(set)
            |> Enum.map(&String.to_integer/1)
            |> IO.inspect()
            |> Enum.sum()
            |> Kernel.-(String.to_integer(first))

          draw(sum * String.to_integer(first))
        else
          List.delete(line, first)
        end
      end)
    end)
  end

  defp draw(num), do: raise(num)

  defp horizontal_board_gen(boards) do
    boards
    |> Enum.map(fn str -> String.split(str, "\n", trim: true) end)
    |> Enum.map(fn board ->
      Enum.map(board, fn line ->
        String.split(line, " ", trim: true)
      end)
    end)
  end

  defp vertical_board_gen(boards) do
    boards
    |> Enum.map(fn line ->
      String.split(line, "\n")
    end)
    |> Enum.map(fn line ->
      Enum.map(line, fn set -> String.split(set, " ", trim: true) end)
      |> Enum.zip()
      |> Enum.map(fn vertical -> Tuple.to_list(vertical) end)
    end)
  end

  defp input() do
    "lib/inputs/04.input"
    |> File.read!()
    |> String.split("\n\n", trim: true)
  end
end
