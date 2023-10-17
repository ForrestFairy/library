defmodule LibraryWeb.Live.LibraryLive.Katalog do
  use LibraryWeb, :live_view

  def mount(%{"katalog" => katalog} = _params, _session, socket) do
    socket = assign(socket, katalog: katalog)
    {:ok, socket}
  end
end
