defmodule PhxTemplate18Dev.CatalogTest do
  use PhxTemplate18Dev.DataCase

  alias PhxTemplate18Dev.Catalog

  describe "products" do
    alias PhxTemplate18Dev.Catalog.Product

    import PhxTemplate18Dev.AccountsFixtures, only: [user_scope_fixture: 0]
    import PhxTemplate18Dev.CatalogFixtures

    @invalid_attrs %{description: nil, title: nil, price: nil, views: nil}

    test "list_products/1 returns all scoped products" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      product = product_fixture(scope)
      other_product = product_fixture(other_scope)
      assert Catalog.list_products(scope) == [product]
      assert Catalog.list_products(other_scope) == [other_product]
    end

    test "get_product!/2 returns the product with given id" do
      scope = user_scope_fixture()
      product = product_fixture(scope)
      other_scope = user_scope_fixture()
      assert Catalog.get_product!(scope, product.id) == product
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_product!(other_scope, product.id) end
    end

    test "create_product/2 with valid data creates a product" do
      valid_attrs = %{
        description: "some description",
        title: "some title",
        price: "120.5",
        views: 42
      }

      scope = user_scope_fixture()

      assert {:ok, %Product{} = product} = Catalog.create_product(scope, valid_attrs)
      assert product.description == "some description"
      assert product.title == "some title"
      assert product.price == Decimal.new("120.5")
      assert product.views == 42
      assert product.user_id == scope.user.id
    end

    test "create_product/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.create_product(scope, @invalid_attrs)
    end

    test "update_product/3 with valid data updates the product" do
      scope = user_scope_fixture()
      product = product_fixture(scope)

      update_attrs = %{
        description: "some updated description",
        title: "some updated title",
        price: "456.7",
        views: 43
      }

      assert {:ok, %Product{} = product} = Catalog.update_product(scope, product, update_attrs)
      assert product.description == "some updated description"
      assert product.title == "some updated title"
      assert product.price == Decimal.new("456.7")
      assert product.views == 43
    end

    test "update_product/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      product = product_fixture(scope)

      assert_raise MatchError, fn ->
        Catalog.update_product(other_scope, product, %{})
      end
    end

    test "update_product/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      product = product_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Catalog.update_product(scope, product, @invalid_attrs)
      assert product == Catalog.get_product!(scope, product.id)
    end

    test "delete_product/2 deletes the product" do
      scope = user_scope_fixture()
      product = product_fixture(scope)
      assert {:ok, %Product{}} = Catalog.delete_product(scope, product)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_product!(scope, product.id) end
    end

    test "delete_product/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      product = product_fixture(scope)
      assert_raise MatchError, fn -> Catalog.delete_product(other_scope, product) end
    end

    test "change_product/2 returns a product changeset" do
      scope = user_scope_fixture()
      product = product_fixture(scope)
      assert %Ecto.Changeset{} = Catalog.change_product(scope, product)
    end
  end
end
