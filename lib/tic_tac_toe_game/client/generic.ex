defmodule TicTacToeGame.Client.Generic do
  defmacro __using__(opts) do
    quote do
      use HTTPoison.Base
      require Logger

      defp try_request(method, url, body \\ "", headers \\ [], params \\ [], retries \\ 1) 

      defp try_request(method, url, body, headers, params, retries) do
        query_params = UriQuery.params(params, add_indices_to_lists: false)
        case request(method, url, body, headers, params: query_params) do
          {:ok, response} ->
            handle_response(method, url, body, headers, params, retries, response)

          error ->
            Logger.error("#{__MODULE__} returned error: #{inspect(error)}")
            error
        end
      end

      def handle_response(method, url, body, headers, params, retries, response) do
        case response do
          %HTTPoison.Response{status_code: status} when status in 200..299 ->
            {:ok, response.body}

          %HTTPoison.Response{status_code: status} when status in 500..599 ->
            Logger.error("#{__MODULE__} returned error: #{inspect(response)}")
            {:error, response}

          %HTTPoison.Response{status_code: 429} when retries < 5 ->
            backoff_time = config()[:backoff_time] || 5000
            Process.sleep(backoff_time * retries)
            try_request(method, url, body, headers, params, retries + 1)

          response ->
            {:error, response}
        end
      end

      def process_response_body(body) do
        Poison.decode!(body)
      rescue
        _ ->
          body
      end

      def process_url(url),
        do: "#{config()[:url]}#{url}"

      def process_request_options(options) do
        [
          recv_timeout: unquote(opts)[:recv_timeout] || 60_000, 
          hackney: [pool: unquote(opts)[:pool] || :default]
        ]
        |> Keyword.merge(options)
      end

      defp config, 
        do: Application.get_env(:tic_tac_toe_game, __MODULE__)
    end
  end
end
