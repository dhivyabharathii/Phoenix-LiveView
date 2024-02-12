defmodule EcommerceWeb.ChatLive.Index do
  use EcommerceWeb, :live_view
  defp username do
    "User #{:rand.uniform(100)}"
  end
  
  def mount(_params, _session, socket) do
    if connected?(socket) do
      EcommerceWeb.Endpoint.subscribe(topic)
    end
    {:ok, assign(socket, username: username, messages: [])}
  end

  def handle_info(%{event: "message", payload: message}, socket) do
    {:noreply, assign(socket, messages: socket.assigns.messages ++ [message])}
  end

  def handle_event("send", %{"text" => text}, socket) do
    EcommerceWeb.Endpoint.broadcast(topic, "message", %{text: text, name: socket.assigns.username})
    {:noreply, socket}
  end

  defp topic do
    "chat"
  end
end
