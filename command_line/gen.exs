defmodule Gen do
  use GenServer

  def init(state) do
    {:ok, state}
  end

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def handle_call(:dequene, _from, []) do
    {:reply, nil, []}
  end

  def handle_call(:dequene, _from, [x | xs]) do
    {:reply, x, xs}
  end

  def handle_call(:quene, _from, state), do: {:reply, state, state}

  def handle_cast({:enquene, value}, state) do
    {:noreply, state ++ [value]}
  end

  def quene do
    GenServer.call(__MODULE__, :quene)
  end

  def dequene do
    GenServer.call(__MODULE__, :dequene)
  end

  def enquene(v) do
    GenServer.cast(__MODULE__, {:enquene, v})
  end
end
