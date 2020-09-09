defmodule ElixirWorkshop.HttpResponseParserTest do
  use ExUnit.Case

  test "Parses 200 responses as successful" do
    response = Pokeapi.TestData.json()

    assert {:ok, _} = HttpResponseParser.parse(response)
  end

  @tag :pending
  test "Decodes JSON responses" do
    response = Pokeapi.TestData.plain_text()

    assert {:ok,
            %{
              "forms" => [
                %{
                  "name" => "ditto",
                  "url" => "https://pokeapi.co/api/v2/pokemon-form/132/"
                }
              ],
              "height" => 3,
              "id" => 132,
              "is_default" => true,
              "name" => "ditto",
              "order" => 203,
              "types" => [
                %{
                  "slot" => 1,
                  "type" => %{
                    "name" => "normal",
                    "url" => "https://pokeapi.co/api/v2/type/1/"
                  }
                }
              ],
              "weight" => 40
            }} = HttpResponseParser.parse(response)
  end

  @tag :pending
  test "Handles plain text responses" do
    response = Pokeapi.TestData.plain_text()

    assert {:ok, "Ditto"} = HttpResponseParser.parse(response)
  end

  @tag :pending
  test "Parses 204 response as empty body" do
    response = Pokeapi.TestData.no_content()

    assert {:ok, ""} = HttpResponseParser.parse(response)
  end

  @tag :pending
  test "parses 404 as not found" do
    response = Pokeapi.TestData.no_content()

    assert {:error, :not_found} = HttpResponseParser.parse(response)
  end

  @tag :pending
  test "parses 401 as unauthorized" do
    response = Pokeapi.TestData.unauthorized()

    assert {:error, :unauthorized} = HttpResponseParser.parse(response)
  end

  @tag :pending
  test "parses other 4xx responses as bad request" do
    response = Pokeapi.TestData.unauthorized()

    assert {:error, :bad_request} =
             HttpResponseParser.parse(%{response | status_code: 402})

    assert {:error, :bad_request} =
             HttpResponseParser.parse(%{response | status_code: 409})

    assert {:error, :bad_request} =
             HttpResponseParser.parse(%{response | status_code: 415})
  end

  @tag :pending
  test "parses 5xx as server error" do
    response = Pokeapi.TestData.server_error()

    assert {:error, :server_error} = HttpResponseParser.parse(response)
  end
end
