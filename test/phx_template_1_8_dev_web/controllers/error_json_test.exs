defmodule PhxTemplate18DevWeb.ErrorJSONTest do
  use PhxTemplate18DevWeb.ConnCase, async: true

  test "renders 404" do
    assert PhxTemplate18DevWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert PhxTemplate18DevWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
