defmodule LibraryWeb.LibraryLive.Home do
  use LibraryWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, sth: 5)
    {:ok, socket}
  end

  def handle_event("inc-size", _tuple, socket) do
    socket = update(socket, :sth, fn size -> size + 1 end)
    {:noreply, socket}
  end
end
