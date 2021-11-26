defmodule SecretFriend.Worker.SFWorker do
    alias SecretFriend.Core.SFList

    def start() do
        spawn(__MODULE__, :loop, [{SFList.new(), nil}])
    end

    def loop({_sflist, _selection} = state) do
        receive do
            {:cast, msg} -> 
                {:noreplay, new_state} = handle_cast(msg, state)
                loop(new_state)
            
            {:call, from, msg} ->
                {:replay, response, new_state} = handle_call(msg, from, state)
                send(from, {:response, response})
                loop(new_state)
        end
    end

    
    # handle_cast(msg, state) -> {:noreplay, new_state}
    def handle_cast({:add_friend, friend}, {sflist, _selection} = _state) do
        new_sflist = SFList.add_friend(sflist, friend)
        {:noreplay, {new_sflist, nil}}
        # Recibe un state, lo modifica y lo devuelve. En este caso el state es la lista.
        # nil porque cuando añades a la lista quieres una nueva selection
    end


    # handle_call(msg, from, state) -> {:replay, response, new_state}
    def handle_call(:create_selection, _from, {sflist, nil} = _state) do
        new_selection = SFList.create_selection(sflist)
        {:replay, new_selection, {sflist, new_selection}}
        # este caso si modifica el estado
    end

    # handle_call(msg, from, state) -> {:replay, response, new_state}
    def handle_call(:create_selection, _from, {_sflist, selection} = state) do
        {:replay, selection, state}
        # este caso no modifica el estado y lo envia tal cual
    end
    
    # handle_call(msg, from, state)
    def handle_call(:show, _from, {sflist, _selection} = state) do
        {:replay, sflist, state}
    end

end