defmodule CryptoScanWeb.Router do
  use CryptoScanWeb, :router
  import CryptoScanWeb.Plugs

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_user
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_user
  end

  scope "/", CryptoScanWeb do
    pipe_through :browser # Use the default browser stack

    resources "/users", UserController, except: [:index]

    resources "/follows", FollowController, except: [:show, :index]

    resources "/alerts", AlertController, except: [:index]

    post "/sessions", SessionController, :login
    delete "/sessions", SessionController, :logout

    get "/", PageController, :index

    get "/currency/:name", CurrencyController, :show
    get "/currency", CurrencyController, :index

    get "/exchange/:name", ExchangeController, :show
    get "/exchange", ExchangeController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", CryptoScanWeb do
  #   pipe_through :api
  # end
end
