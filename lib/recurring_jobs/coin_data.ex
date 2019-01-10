defmodule RecurringJobs.CoinData do
  def fetch(coin) do
    %{"data" => data_params} = coin
      |> Atom.to_string()
      |> url()
      |> HTTPoison.get!()
      |> Map.get(:body)
      |> Jason.decode!()
    data_params["priceUsd"]
  end

  defp url(coin) do
    "https://api.coincap.io/v2/assets/" <> coin
  end
end