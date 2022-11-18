defmodule HartingWeb.PageController do
  use HartingWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
