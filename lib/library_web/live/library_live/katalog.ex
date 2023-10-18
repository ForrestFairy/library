defmodule LibraryWeb.Live.LibraryLive.Katalog do
  use LibraryWeb, :live_view
  alias Library.Books

  def mount(%{"katalog" => katalog} = _params, _session, socket) do
    socket =
      assign(socket,
        katalog: katalog,
        book: "",
        matches: [],
        books: [],
        loading: false
      )

    {:ok, socket}
  end

  def handle_event("book-search", %{"book" => book}, socket) do
    send(self(), {:run_book_search, book})

    socket =
      assign(socket,
        book: book,
        loading: true
      )

    {:noreply, socket}
  end

  def handle_event("suggest-book", %{"book" => prefix}, socket) do
    socket = assign(socket, matches: Books.suggest(socket.assigns.katalog, prefix))
    {:noreply, socket}
  end

  def handle_info({:run_book_search, book}, socket) do
    case Books.search_by_title(socket.assigns.katalog, book) do
      [] ->
        socket =
          socket
          |> put_flash(:info, "Brak pasujących książek do \"#{book}\"")
          |> assign(books: [], loading: false)

        {:noreply, socket}

      books ->
        socket = assign(socket, books: books, loading: false)
        {:noreply, socket}
    end
  end
end
