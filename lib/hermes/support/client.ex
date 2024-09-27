defmodule Client do
  use GenServer

  def start_link(topic) do
    GenServer.start_link(__MODULE__, topic)
  end

  def init(topic) do
    Hermes.subscribe(topic)
    {:ok, topic}
  end

  def handle_info(msg, state) do
    IO.puts("Received: #{inspect(msg)}")
    {:noreply, state}
  end
end
