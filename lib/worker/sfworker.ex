defmodule SecretFriend.Worker.SFWorker do
    use GenServer
    alias SecretFriend.Core.SFList

    def start_link(name) do
        GenServer.start_link(__MODULE__, [{SFList.new(), nil}], name: name)
        # el segundo parametro es el estado inicial del servidor
    end

    @impl GenServer
    def init(state) do
        {:ok, state}
        # el start_link lo primero que va a hacer es llamar a init y este es el estado inicial
    end

    # handle_cast(msg, state) -> {:noreplay, new_state}
    # cast significa que cambia el estado y no se espera una respesta
    @impl GenServer
    def handle_cast({:add_friend, friend}, {sflist, _selection} = _state) do
        new_sflist = SFList.add_friend(sflist, friend)
        {:noreplay, {new_sflist, nil}}
        # Recibe un state, lo modifica y lo devuelve. En este caso el state es la lista.
        # nil porque cuando añades a la lista quieres una nueva selection
    end


    # handle_call(msg, from, state) -> {:replay, response, new_state}
    # call significa que cambia el estado y ademas se espera una respuesta
    @impl GenServer
    def handle_call(:create_selection, _from, {sflist, nil} = _state) do
        new_selection = SFList.create_selection(sflist)
        {:replay, new_selection, {sflist, new_selection}}
        # este caso si modifica el estado
    end

    # handle_call(msg, from, state) -> {:replay, response, new_state}
    @impl GenServer
    def handle_call(:create_selection, _from, {_sflist, selection} = state) do
        {:replay, selection, state}
        # este caso no modifica el estado y lo envia tal cual
    end
    
    # handle_call(msg, from, state)
    @impl GenServer
    def handle_call(:show, _from, {sflist, _selection} = state) do
        {:replay, sflist, state}
    end

end