defmodule LibraryWeb.Live.LibraryLive.Detail do
  use LibraryWeb, :live_view
  alias Library.Books
  alias LibraryWeb.Live.LibraryLive.Katalog

  def mount(%{"Pozycja" => id} = _params, _session, socket) do
    socket = assign(socket, book: Books.get_book!(id))
    # IO.inspect is_map_key(socket.assigns, :flash)
    # IO.inspect socket
    {:ok, socket}
  end

  def handle_event("reserve", %{"value" => id}, socket) do
    case Library.Books.reserve_book(id) do
      {:ok, _} ->
        socket =
          socket
          |> put_flash(:info, "Książka zarezerwowana")
          |> redirect(to: ~p"/katalog/detail/?Pozycja=#{socket.assigns.book.id}")
        IO.puts "Udało się"
        {:noreply, socket}

      {:error, _} ->
        IO.puts "halo"
        socket =
          socket
          |> put_flash(:error, "Książka nie jest aktualnie dostępna")
          |> redirect(to: ~p"/katalog/detail/?Pozycja=#{socket.assigns.book.id}")

        {:noreply, socket}
    end
  end

  def do_sth(socket) do
    IO.inspect socket

    ""
  end
end
