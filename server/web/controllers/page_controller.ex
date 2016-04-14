defmodule Chatserver.PageController do
  use Chatserver.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
