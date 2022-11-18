defmodule HartingWeb.ExcelLive.Index do
  use HartingWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    path = Path.join(Application.app_dir(:harting), "/priv/test.xlsx")
    IO.puts path

    shite = Xlsxir.multi_extract(path)
    IO.inspect shite

    {:ok, socket}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end
end
