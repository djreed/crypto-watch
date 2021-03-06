defmodule CryptoScanWeb.ExchangeController do
  use CryptoScanWeb, :controller

  def index(conn, _params) do
    exchanges = CryptoScan.Exchange.values

    render(conn, "index.html", exchanges: exchanges)
  end

  def show(conn, %{"name" => name}) do
    if !Enum.member? CryptoScan.Exchange.values, name do
      conn
      |> put_flash(:error, "Exchange '" <> name <> "' does not exist.")
      |> redirect(to: exchange_path(conn, :index))
    end

    allPrices = CryptoScan.priceAllCurrencies(name)

    follow = %CryptoScan.Connectors.Follow{
      user: "",
      currency: "",
      exchange: "",
    }
    follow = CryptoScan.Connectors.change_follow(follow)

    render(conn, "show.html", allPrices: allPrices, follow: follow, name: name)
  end
end
