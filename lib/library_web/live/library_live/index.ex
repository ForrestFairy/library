defmodule LibraryWeb.Live.LibraryLive.Index do
  use LibraryWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, size: 5)
    {:ok, socket}
  end

  def handle_event("inc-size", _tuple, socket) do
    socket = update(socket, :size, fn size -> size + 1 end)
    {:noreply, socket}
  end

end
