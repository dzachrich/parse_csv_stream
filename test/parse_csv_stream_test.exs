defmodule ParseCsvStreamTest do
  use ExUnit.Case
  doctest ParseCsvStream

  test "reads file input" do
    expected_content =  {:ok,
      [
        %{game_id: "3349", original_filename: "3349.mp4", uuid: "3d4d9dc8-255e-47a4-a7e1-7b623ea202a7"},
        %{game_id: "3350", original_filename: "3350.mp4", uuid: "c339c6b6-6ba2-49c9-b73b-2454645066aa"},
        %{game_id: "3351", original_filename: "3351.mp4", uuid: "ee0b4238-15f6-41a5-a58e-8a3b276728da"},
        %{game_id: "3352", original_filename: "3352.mp4", uuid: "b63dde1f-2a81-4f7d-8bff-9192949a6b9a"},
        %{game_id: "3354", original_filename: "3354.mp4", uuid: "6d376cec-e21e-4259-a6fd-2c972e029991"}
      ]}

    pathname = "test/fixtures/file.csv"

    # Read the contents of the file
    {:ok, file_contents} = File.read(path)

    # Assert that the contents match the expected content
    assert file_contents == expected_content
  end
end
