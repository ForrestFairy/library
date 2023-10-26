defmodule LibraryWeb.Live.LibraryLive.Katalog do
  use LibraryWeb, :live_view
  alias Library.Books
  alias LibraryWeb.Live.LibraryLive.Katalog

  def mount(%{"katalog" => katalog} = params, _session, socket) do
    page =
      case params["page"] do
        nil -> 1
        p -> String.to_integer(p)
      end

    katalog = String.to_integer(katalog)
    pagination = Books.list_katalog(katalog, page)

    socket =
      assign(socket,
        katalog: katalog,
        book: "",
        matches: [],
        page: page,
        books: pagination.list,
        loading: false,
        has_next: pagination.has_next,
        has_prev: pagination.has_prev
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

  def handle_event("next-page", %{"value" => page}, socket) do
    page = String.to_integer(page)

    {:noreply, redirect(socket, to: ~p"/katalog/ini?katalog=#{socket.assigns.katalog}&page=#{page + 1}")}
  end

  def handle_event("prev-page", %{"value" => page}, socket) do
    page = String.to_integer(page)

    {:noreply, redirect(socket, to: ~p"/katalog/ini?katalog=#{socket.assigns.katalog}&page=#{page - 1}")}
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


  def katalog_name(0), do: "Centralny"
  def katalog_name(1), do: "Mediateka START-STOP"
  def katalog_name(_), do: "Reszta niezrobiona"

  def do_sth(socket) do
    IO.inspect socket

    ""
  end
end
