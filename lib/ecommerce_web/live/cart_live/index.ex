defmodule EcommerceWeb.CartLive.Index do
  use Phoenix.LiveView
  alias EcommerceWeb.CartLive.ProductItem
  alias Ecommerce.Catalog
  alias Ecommerce.Repo

  def mount(_params,_session,socket) do
    product=Catalog.fetch_all_titles()
    {:ok, assign(socket, total_items: 0, product: product)}
  end

  def handle_params(params, _,socket) do
    name= params["name"] || "guest"
    {:noreply, assign(socket, name: name)}
  end

  def render(assigns) do
    ~H"""

    <div class="w-full max-w-md p-6 bg-white rounded-lg shadow-md" >
    <h2 class="text-2xl font-semibold mb-3"> Shopping Cart - Total Items: <%= @total_items %></h2>
      <.live_component  :for={id <-@product} module={ProductItem} id={id} />
    </div>
    """

  end

  def handle_info(:add, socket) do
    {:noreply, update(socket, :total_items, &(&1 + 1))}
  end
end
