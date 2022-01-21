defmodule SecretFriend.API.SFList do
    alias SecretFriend.Worker.SFWorker
    alias SecretFriend.Boundary.SFListsSupervisor

    def new(name) do
        # con este cambio nuestra API ya no depende del Worker si no del supervisor
        SFListsSupervisor.create_sflist(name)
        name
    end

    def add_friend(name, friend) do
        case GenServer.call(name, {:add_friend, friend}) do
            :ok -> name
            :locked -> :locked
        end
    end

    def create_selection(name) do
        GenServer.call(name, :create_selection)
    end

    def show(name) do
        GenServer.call(name, :show)
    end

    # name es el nombre del proceso que contiene un state
    def lock?(name) do
        GenServer.call(name, :lock?)
    end

    # cuando recibimos este mensaje ya no podemos añadir mas amigos
    def lock(name) do
        GenServer.cast(name, :lock)
    end

end
