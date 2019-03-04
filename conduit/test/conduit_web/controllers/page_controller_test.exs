defmodule ConduitWeb.PageControllerTest do
  use ConduitWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Conduit · Phoenix Framework"
  end
end
