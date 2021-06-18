defmodule Noisex.Utils do
  @moduledoc """
  Utilitary functions for working with noise maps.
  """

  alias Noisex.Noise
  alias Noisex.NIF

  @doc """
  Writes the given noise map to a file.
  `filename` requires an extension (`.png` is recommended).
  """
  @spec write_to_file(Noise.noisemap(), String.t()) ::
          {:ok, :wrote} | {:error, String.t()}
  def write_to_file(noisemap, filename) do
    NIF.write_to_file(noisemap, filename)
  end

  @doc """
  Shows the given noise map on the stdout using ANSI color codes.
  > This won't work if your terminal doesn't support ANSI color codes.
  """
  @spec show_noisemap(Noise.noisemap()) :: :ok
  def show_noisemap(noisemap) do
    Enum.each(noisemap, fn y ->
      Enum.each(y, fn x ->
        color = (x * 255) |> floor() |> abs() |> rem(255)
        ansi_char = IO.ANSI.color(color) <> "▒"
        IO.write(ansi_char)
      end)

      IO.puts("")
    end)
  end
end
