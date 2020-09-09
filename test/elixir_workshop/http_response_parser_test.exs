defmodule ElixirWorkshop.HttpResponseParserTest do
  use ExUnit.Case

  alias ElixirWorkshop.{HttpResponseParser, Response}

  test "Parses 200 responses as successful" do
    assert {:ok, _} = HttpResponseParser.parse(@json)
  end

  @tag :pending
  test "Decodes JSON responses" do
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
            }} = HttpResponseParser.parse(@json)
  end

  @tag :pending
  test "Handles plain text responses" do
    assert {:ok, "Ditto"} = HttpResponseParser.parse(@plain_text)
  end

  @tag :pending
  test "Parses 204 response as empty body" do
    assert {:ok, ""} = HttpResponseParser.parse(@no_content)
  end

  @tag :pending
  test "parses 404 as not found" do
    assert {:error, :not_found} = HttpResponseParser.parse(@not_found)
  end

  @tag :pending
  test "parses 401 as unauthorized" do
    assert {:error, :unauthorized} = HttpResponseParser.parse(@unauthorized)
  end

  @tag :pending
  test "parses other 4xx responses as bad request" do
    assert {:error, :bad_request} =
             HttpResponseParser.parse(%{@unauthorized | status_code: 402})

    assert {:error, :bad_request} =
             HttpResponseParser.parse(%{@unauthorized | status_code: 409})

    assert {:error, :bad_request} =
             HttpResponseParser.parse(%{@unauthorized | status_code: 415})
  end

  @tag :pending
  test "parses 5xx as server error" do
    assert {:error, :server_error} = HttpResponseParser.parse(@server_error)
  end

  ######### FIXTURES #########
  @json %Response{
    body:
      "{\"forms\":[{\"name\":\"ditto\",\"url\":\"https://pokeapi.co/api/v2/pokemon-form/132/\"}],\"height\":3,\"id\":132,\"is_default\":true,\"name\":\"ditto\",\"order\":203,\"types\":[{\"slot\":1,\"type\":{\"name\":\"normal\",\"url\":\"https://pokeapi.co/api/v2/type/1/\"}}],\"weight\":40}",
    headers: [
      {"Date", "Wed, 09 Sep 2020 05:38:11 GMT"},
      {"Content-Type", "application/json; charset=utf-8"},
      {"Transfer-Encoding", "chunked"},
      {"Connection", "keep-alive"},
      {"Access-Control-Allow-Origin", "*"},
      {"Cache-Control", "public, max-age=86400, s-maxage=86400"},
      {"X-Cloud-Trace-Context", "575b8dfb1db4a4a902a48b8cd3e430b7"},
      {"X-Country-Code", "US"},
      {"X-Orig-Accept-Language", "en-US,en;q=0.9,tr-TR;q=0.8,tr;q=0.7"},
      {"X-Powered-By", "Express"},
      {"X-Served-By", "cache-sea4452-SEA"},
      {"X-Cache", "MISS"},
      {"X-Cache-Hits", "0"},
      {"X-Timer", "S1598342153.575237,VS0,VE540"},
      {"Vary",
       "Accept-Encoding,cookie,need-authorization, x-fh-requested-host, accept-encoding"},
      {"CF-Cache-Status", "HIT"},
      {"Age", "48202"},
      {"cf-request-id", "0512eb063b0000f5b901281200000001"},
      {"Expect-CT",
       "max-age=604800, report-uri=\"https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct\""},
      {"Server", "cloudflare"},
      {"CF-RAY", "5cfe8fc46faec989-SEA"}
    ],
    request: %{
      body: "",
      headers: [],
      method: :get,
      options: [],
      params: %{},
      url: "https://pokeapi.co/api/v2/pokemon/ditto"
    },
    request_url: "https://pokeapi.co/api/v2/pokemon/ditto",
    status_code: 200
  }

  @plain_text %Response{
    body: "Ditto",
    headers: [
      {"Date", "Wed, 09 Sep 2020 05:38:11 GMT"},
      {"Content-Type", "text/plain; charset=utf-8"},
      {"Transfer-Encoding", "chunked"},
      {"Connection", "keep-alive"},
      {"Access-Control-Allow-Origin", "*"},
      {"Cache-Control", "public, max-age=86400, s-maxage=86400"},
      {"X-Cloud-Trace-Context", "575b8dfb1db4a4a902a48b8cd3e430b7"},
      {"X-Country-Code", "US"},
      {"X-Orig-Accept-Language", "en-US,en;q=0.9,tr-TR;q=0.8,tr;q=0.7"},
      {"X-Powered-By", "Express"},
      {"X-Served-By", "cache-sea4452-SEA"},
      {"X-Cache", "MISS"},
      {"X-Cache-Hits", "0"},
      {"X-Timer", "S1598342153.575237,VS0,VE540"},
      {"Vary",
       "Accept-Encoding,cookie,need-authorization, x-fh-requested-host, accept-encoding"},
      {"CF-Cache-Status", "HIT"},
      {"Age", "48202"},
      {"cf-request-id", "0512eb063b0000f5b901281200000001"},
      {"Expect-CT",
       "max-age=604800, report-uri=\"https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct\""},
      {"Server", "cloudflare"},
      {"CF-RAY", "5cfe8fc46faec989-SEA"}
    ],
    request: %{
      body: "",
      headers: [],
      method: :get,
      options: [],
      params: %{},
      url: "https://pokeapi.co/api/v2/pokemon/ditto"
    },
    request_url: "https://pokeapi.co/api/v2/pokemon/ditto",
    status_code: 200
  }

  @no_content %Response{
    body: "",
    headers: [
      {"Date", "Wed, 09 Sep 2020 05:38:11 GMT"},
      {"Content-Type", "text/plain; charset=utf-8"},
      {"Transfer-Encoding", "chunked"},
      {"Connection", "keep-alive"},
      {"Access-Control-Allow-Origin", "*"},
      {"Cache-Control", "public, max-age=86400, s-maxage=86400"},
      {"X-Cloud-Trace-Context", "575b8dfb1db4a4a902a48b8cd3e430b7"},
      {"X-Country-Code", "US"},
      {"X-Orig-Accept-Language", "en-US,en;q=0.9,tr-TR;q=0.8,tr;q=0.7"},
      {"X-Powered-By", "Express"},
      {"X-Served-By", "cache-sea4452-SEA"},
      {"X-Cache", "MISS"},
      {"X-Cache-Hits", "0"},
      {"X-Timer", "S1598342153.575237,VS0,VE540"},
      {"Vary",
       "Accept-Encoding,cookie,need-authorization, x-fh-requested-host, accept-encoding"},
      {"CF-Cache-Status", "HIT"},
      {"Age", "48202"},
      {"cf-request-id", "0512eb063b0000f5b901281200000001"},
      {"Expect-CT",
       "max-age=604800, report-uri=\"https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct\""},
      {"Server", "cloudflare"},
      {"CF-RAY", "5cfe8fc46faec989-SEA"}
    ],
    status_code: 204,
    request: %{
      body: "",
      headers: [],
      method: :get,
      options: [],
      params: %{},
      url: "https://pokeapi.co/api/v2/pokemon/ditto"
    },
    request_url: "https://pokeapi.co/api/v2/pokemon/ditto"
  }

  @not_found %Response{
    body: "Not found",
    status_code: 404,
    headers: [
      {"Date", "Wed, 09 Sep 2020 05:38:11 GMT"},
      {"Content-Type", "text/plain; charset=utf-8"},
      {"Content-Length", "9"},
      {"Connection", "keep-alive"},
      {"Set-Cookie",
       "__cfduid=da5714e848d01bcb08c7c21fcd7950cb71599629891; expires=Fri, 09-Oct-20 05:38:11 GMT; path=/; domain=.pokeapi.co; HttpOnly; SameSite=Lax; Secure"},
      {"Access-Control-Allow-Origin", "*"},
      {"Cache-Control", "public, max-age=86400, s-maxage=86400"},
      {"Etag", "W/\"9-0gXL1ngzMqISxa6S1zx3F4wtLyg\""},
      {"Function-Execution-Id", "7el9y52g3dkm"},
      {"X-Cloud-Trace-Context", "d37ae1c945b3a9402f408ea42b43c1da"},
      {"X-Powered-By", "Express"},
      {"X-Served-By", "cache-sea4450-SEA"},
      {"X-Cache", "MISS"},
      {"X-Cache-Hits", "0"},
      {"X-Timer", "S1599629891.283832,VS0,VE707"},
      {"Vary", "Accept-Encoding, x-fh-requested-host, accept-encoding"},
      {"CF-Cache-Status", "MISS"},
      {"cf-request-id", "0512f82ec30000c98937acb200000001"},
      {"Expect-CT",
       "max-age=604800, report-uri=\"https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct\""},
      {"Server", "cloudflare"},
      {"CF-RAY", "5cfe8fc46faec989-SEA"}
    ],
    request: %{
      body: "",
      headers: [],
      method: :get,
      options: [],
      params: %{},
      url: "https://pokeapi.co/api/v2/pokemon/does-not-exist"
    },
    request_url: "https://pokeapi.co/api/v2/pokemon/does-not-exist"
  }

  @unauthorized %Response{
    body: "Not authorized",
    status_code: 401,
    headers: [
      {"Date", "Wed, 09 Sep 2020 05:38:11 GMT"},
      {"Content-Type", "text/plain; charset=utf-8"},
      {"Content-Length", "9"},
      {"Connection", "keep-alive"},
      {"Set-Cookie",
       "__cfduid=da5714e848d01bcb08c7c21fcd7950cb71599629891; expires=Fri, 09-Oct-20 05:38:11 GMT; path=/; domain=.pokeapi.co; HttpOnly; SameSite=Lax; Secure"},
      {"Access-Control-Allow-Origin", "*"},
      {"Cache-Control", "public, max-age=86400, s-maxage=86400"},
      {"Etag", "W/\"9-0gXL1ngzMqISxa6S1zx3F4wtLyg\""},
      {"Function-Execution-Id", "7el9y52g3dkm"},
      {"X-Cloud-Trace-Context", "d37ae1c945b3a9402f408ea42b43c1da"},
      {"X-Powered-By", "Express"},
      {"X-Served-By", "cache-sea4450-SEA"},
      {"X-Cache", "MISS"},
      {"X-Cache-Hits", "0"},
      {"X-Timer", "S1599629891.283832,VS0,VE707"},
      {"Vary", "Accept-Encoding, x-fh-requested-host, accept-encoding"},
      {"CF-Cache-Status", "MISS"},
      {"cf-request-id", "0512f82ec30000c98937acb200000001"},
      {"Expect-CT",
       "max-age=604800, report-uri=\"https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct\""},
      {"Server", "cloudflare"},
      {"CF-RAY", "5cfe8fc46faec989-SEA"}
    ],
    request: %{
      body: "",
      headers: [],
      method: :get,
      options: [],
      params: %{},
      url: "https://pokeapi.co/api/v2/pokemon/does-not-exist"
    },
    request_url: "https://pokeapi.co/api/v2/pokemon/does-not-exist"
  }

  @server_error %Response{
    body: "Server error",
    status_code: 500,
    headers: [
      {"Date", "Wed, 09 Sep 2020 05:38:11 GMT"},
      {"Content-Type", "text/plain; charset=utf-8"},
      {"Content-Length", "9"},
      {"Connection", "keep-alive"},
      {"Set-Cookie",
       "__cfduid=da5714e848d01bcb08c7c21fcd7950cb71599629891; expires=Fri, 09-Oct-20 05:38:11 GMT; path=/; domain=.pokeapi.co; HttpOnly; SameSite=Lax; Secure"},
      {"Access-Control-Allow-Origin", "*"},
      {"Cache-Control", "public, max-age=86400, s-maxage=86400"},
      {"Etag", "W/\"9-0gXL1ngzMqISxa6S1zx3F4wtLyg\""},
      {"Function-Execution-Id", "7el9y52g3dkm"},
      {"X-Cloud-Trace-Context", "d37ae1c945b3a9402f408ea42b43c1da"},
      {"X-Powered-By", "Express"},
      {"X-Served-By", "cache-sea4450-SEA"},
      {"X-Cache", "MISS"},
      {"X-Cache-Hits", "0"},
      {"X-Timer", "S1599629891.283832,VS0,VE707"},
      {"Vary", "Accept-Encoding, x-fh-requested-host, accept-encoding"},
      {"CF-Cache-Status", "MISS"},
      {"cf-request-id", "0512f82ec30000c98937acb200000001"},
      {"Expect-CT",
       "max-age=604800, report-uri=\"https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct\""},
      {"Server", "cloudflare"},
      {"CF-RAY", "5cfe8fc46faec989-SEA"}
    ],
    request: %{
      body: "",
      headers: [],
      method: :get,
      options: [],
      params: %{},
      url: "https://pokeapi.co/api/v2/pokemon/does-not-exist"
    },
    request_url: "https://pokeapi.co/api/v2/pokemon/does-not-exist"
  }
end
