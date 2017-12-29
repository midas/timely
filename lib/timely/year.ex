defmodule Timely.Year do
  @moduledoc """
  Provides functions for manipulating year numbers.
  """

  @doc """
  Computes the century of the specified `year`.

  ## Examples

      iex> Timely.Year.century 1900
      19

      iex> Timely.Year.century 34
      0
  """
  @spec century( integer ) :: integer
  def century( year ), do: trunc( year / 100 )

  @doc """
  Interprets the specified `number` as a year. If necessary, it guesses the
  century nearest the specified `:near` option.

  ## Examples

      iex> Timely.Year.guess 17, near: 2017
      {:ok, 2017}

      iex> Timely.Year.guess 67, near: 2017
      {:ok, 1967}

      iex> Timely.Year.guess 66, near: 2017
      {:ok, 2066}

      iex> Timely.Year.guess 2017, near: 2017
      {:ok, 2017}

      iex> Timely.Year.guess 2017, near: 17
      {:error, ":near value 17 has no century"}
  """
  @spec guess( integer, [near: integer] ) :: {:ok, integer} | {:error, binary}
  def guess( number, near: near ) when is_integer ( number ) do
    with :ok <- validate( near: near ) do
      year = case century( number ) do
               0 ->
                 near_century = century( near ) * 100
                 number_in_near_century = near_century + number
                 if abs( number_in_near_century - near ) < 50 do
                   number_in_near_century
                 else
                   number_in_near_century - ( sign( number ) * 100 )
                 end
               _ ->
                 number
             end
      {:ok, year}
    end
  end

  @spec sign( integer ) :: -1 | 0 | 1
  defp sign( number ) when number < 0, do: -1
  defp sign( number ) when 0 < number, do:  1
  defp sign( _number ),                do:  0

  @spec validate( [near: integer] ) :: :ok | {:error, binary}
  defp validate( near: near ) do
    case century( near ) do
      0 -> {:error, ":near value #{inspect near} has no century"}
      _ -> :ok
    end
  end
end
