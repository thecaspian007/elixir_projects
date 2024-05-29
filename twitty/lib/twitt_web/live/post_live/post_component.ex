defmodule TwittWeb.PostLive.PostComponent do
  use TwittWeb, :live_component

  alias Twitt.Timeline

  def render(assigns) do
    ~H"""
    <div id={"post-#{@post.id}"} class="tweet">
      <div class="tweet-header">
        <img src="https://via.placeholder.com/50" alt={@post.username} />
        <span class="username">@<%= @post.username %></span>
      </div>
      <div class="tweet-content">
        <p><%= @post.body %></p>
      </div>
      <div class="tweet-actions">
        <button phx-click="like" phx-target={@myself}>
          💟 <%= @post.likes_count %>
        </button>
        <button phx-click="repost" phx-target={@myself}>
          🔄 <%= @post.reposts_count %>
        </button>
        <%= live_patch to: Routes.post_index_path(@socket, :edit, @post.id) do %>
          ✏️
        <% end %>
        <%= link to: "#", phx_click: "delete", phx_value_id: @post.id, data: [confirm: "Are you sure?"] do %>
          ❌
        <% end %>
      </div>
    </div>
    """
  end

  def handle_event("delete", _, socket) do
    {:noreply, socket}
  end

  def handle_event("like", _, socket) do
    Twitt.Timeline.inc_likes(socket.assigns.post)
    {:noreply, socket}
  end

  def handle_event("repost", _, socket) do
    Twitt.Timeline.inc_reposts(socket.assigns.post)
    {:noreply, socket}
  end
end
