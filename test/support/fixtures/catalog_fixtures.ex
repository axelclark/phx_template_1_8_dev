defmodule PhxTemplate18Dev.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhxTemplate18Dev.Catalog` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        description: "some description",
        price: "120.5",
        title: "some title",
        views: 42
      })

    {:ok, product} = PhxTemplate18Dev.Catalog.create_product(scope, attrs)
    product
  end
end
