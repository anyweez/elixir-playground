defmodule ChatServer.Router do 
    use Phoenix.Router, port: 4000
    
    get "/", ChatServer.Controllers.Pages, :index #, as: :page
end