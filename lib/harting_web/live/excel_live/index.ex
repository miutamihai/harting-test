defmodule HartingWeb.ExcelLive.Index do
  use HartingWeb, :live_view

  defp extract_table_id({:ok, table_id}) do
    table_id
  end

  @impl true
  def mount(_params, _session, socket) do
    path = Path.join(Application.app_dir(:harting), "/priv/test.xlsx")

    tables =
      Xlsxir.multi_extract(path)
      |> (Enum.map &extract_table_id/1)
      |> (Enum.map &Xlsxir.get_list/1)

    {:ok, assign(socket, :tables, tables)}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end
end
