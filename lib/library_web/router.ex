defmodule LibraryWeb.Router do
  # alias LibraryWeb.LibraryLive
  use LibraryWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {LibraryWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LibraryWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/katalog/index", Live.LibraryLive.Index, :index
    live "/katalog/regulamin", Live.LibraryLive.Regulamin, :regulamin
    live "/katalog/pomoc", Live.LibraryLive.Pomoc, :pomoc
    live "/katalog/logowanie", Live.LibraryLive.Konto, :logowanie
    live "/katalog/ini", Live.LibraryLive.Katalog, :katalog
    live "/katalog/detail", Live.LibraryLive.Detail, :detail
  end

  # Other scopes may use custom stacks.
  # scope "/api", LibraryWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:library, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: LibraryWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
