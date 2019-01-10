defmodule RecurringJobs.CoinDataWorker do
  use GenServer

  alias RecurringJobs.CoinData

  def start_link(portefolio) do
    GenServer.start_link(__MODULE__, portefolio)
  end

  def init(portefolio) do
    schedule_coin_fetch()
    {:ok, portefolio}
  end

  def handle_info(:coin_fetch, portefolio) do
    %{id: coin} = portefolio
    price = CoinData.fetch(coin)

    if portefolio[:price] == price do
      IO.puts("Current #{coin} price: #{price}$")
    end
    schedule_coin_fetch()
    {:noreply, portefolio |> Map.put(:price, price)}
  end

  defp schedule_coin_fetch do
    Process.send_after(self(), :coin_fetch, 5000)
  end
end