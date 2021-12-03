defmodule SecretFriend.Worker.SFWorker do
    use GenServer
    alias SecretFriend.Core.SFList

    def start_link(name) do
        GenServer.start_link(__MODULE__, %{sflist: SFList.new(), selection: nil, lock: false}, name: name)
        # el segundo parametro es el estado inicial del servidor
    end

    @impl GenServer
    def init(state) do
        {:ok, state}
        # el start_link lo primero que va a hacer es llamar a init y este es el estado inicial
    end


    @impl GenServer
    def handle_cast(:lock, state) do
        {:noreply, %{state | lock: true}}
    end

    # handle_cast(msg, state) -> {:noreplay, new_state}
    # cast significa que cambia el estado y no se espera una respesta
    @impl GenServer
    def handle_call({:add_friend, friend}, _from, %{sflist: sflist, lock: false} = state) do
        new_sflist = SFList.add_friend(sflist, friend)
        {:reply, :ok, %{state | sflist: new_sflist, selection: nil}}
        # Recibe un state, lo modifica y lo devuelve. En este caso el state es la lista.
        # nil porque cuando añades a la lista quieres una nueva selection
    end

    # este seria el mensaje de cuando intentas añadir un amigo pero está bloqueado
    @impl GenServer
    def handle_call({:add_friend, _friend}, _from, %{lock: true} = state) do
        {:reply, :locked, state}
    end

    # handle_call(msg, from, state) -> {:replay, response, new_state}
    # call significa que cambia el estado y ademas se espera una respuesta
    @impl GenServer
    def handle_call(:create_selection, _from, %{sflist: sflist, selection: nil} = state) do
        new_selection = SFList.create_selection(sflist)
        {:reply, new_selection, %{state | selection: new_selection}}
        # este caso si modifica el estado
    end

    # handle_call(msg, from, state) -> {:replay, response, new_state}
    @impl GenServer
    def handle_call(:create_selection, _from, %{selection: selection} = state) do
        {:reply, selection, state}
        # este caso no modifica el estado y lo envia tal cual
    end
    
    # handle_call(msg, from, state)
    @impl GenServer
    def handle_call(:show, _from, %{sflist: sflist} = state) do
        {:reply, sflist, state}
    end

    @impl GenServer
    def handle_call(:lock?, _from, %{lock: lock} = state) do
        {:reply, lock, state}
    end

end