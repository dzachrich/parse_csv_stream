defmodule ParseCsvStream do

  alias NimbleCSV.RFC4180, as: NimbleCSV
  @moduledoc """
  Documentation for `ParseCsvStream`.
  """

  @doc """
  Parse Csv Stream

  Streams and parses the CSV file specified by pathname, and returns an {:ok, result} tuple
  where result is a list of maps keyed by the column names of the CSV file.
  If the file does not exist, returns an empty list.

  Example:
    game_id,uuid,original_filename
    3349,3d4d9dc8-255e-47a4-a7e1-7b623ea202a7,3349.mp4
    3350,c339c6b6-6ba2-49c9-b73b-2454645066aa,3350.mp4
    3351,ee0b4238-15f6-41a5-a58e-8a3b276728da,3351.mp4
    3352,b63dde1f-2a81-4f7d-8bff-9192949a6b9a,3352.mp4
    3354,6d376cec-e21e-4259-a6fd-2c972e029991,3354.mp4

    Returns:
    {:ok,
      [
       %{game_id: "3349", original_filename: "3349.mp4", uuid: "3d4d9dc8-255e-47a4-a7e1-7b623ea202a7"},
       %{game_id: "3350", original_filename: "3350.mp4", uuid: "c339c6b6-6ba2-49c9-b73b-2454645066aa"},
       %{game_id: "3351", original_filename: "3351.mp4", uuid: "ee0b4238-15f6-41a5-a58e-8a3b276728da"},
       %{game_id: "3352", original_filename: "3352.mp4", uuid: "b63dde1f-2a81-4f7d-8bff-9192949a6b9a"},
       %{game_id: "3354", original_filename: "3354.mp4", uuid: "6d376cec-e21e-4259-a6fd-2c972e029991"}
      ]}

  """
  def parse_csv_stream(pathname) do
    pathname
    |> File.stream!()
    |> NimbleCSV.parse_stream(skip_headers: false)
    |> Stream.transform([], &transform/2)
    |> Enum.to_list()
  end

  defp transform(r, []) do
    {%{}, Enum.map(r, &String.to_atom/1)}
  end

  defp transform(r, acc) do
    {[acc |> Enum.zip(r) |> Enum.into(%{})], acc}
  end
end
