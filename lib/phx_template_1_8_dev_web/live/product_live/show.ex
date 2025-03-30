defmodule PhxTemplate18DevWeb.ProductLive.Show do
  use PhxTemplate18DevWeb, :live_view

  alias PhxTemplate18Dev.Catalog

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Product {@product.id}
        <:subtitle>This is a product record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/products"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/products/#{@product}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit product
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@product.title}</:item>
        <:item title="Description">{@product.description}</:item>
        <:item title="Price">{@product.price}</:item>
        <:item title="Views">{@product.views}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    Catalog.subscribe_products(socket.assigns.current_scope)

    {:ok,
     socket
     |> assign(:page_title, "Show Product")
     |> assign(:product, Catalog.get_product!(socket.assigns.current_scope, id))}
  end

  @impl true
  def handle_info(
        {:updated, %PhxTemplate18Dev.Catalog.Product{id: id} = product},
        %{assigns: %{product: %{id: id}}} = socket
      ) do
    {:noreply, assign(socket, :product, product)}
  end

  def handle_info(
        {:deleted, %PhxTemplate18Dev.Catalog.Product{id: id}},
        %{assigns: %{product: %{id: id}}} = socket
      ) do
    {:noreply,
     socket
     |> put_flash(:error, "The current product was deleted.")
     |> push_navigate(to: ~p"/products")}
  end
end
