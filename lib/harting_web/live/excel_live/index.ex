defmodule HartingWeb.ExcelLive.Index do
  use HartingWeb, :live_view

  defp extract_table(index) do
    path = Path.join(Application.app_dir(:harting), "/priv/test.xlsx")

    Xlsxir.multi_extract(path, index)
  end

  defp extract_table_id({:ok, table_id}) do
    table_id
  end

  defp ref_to_string(reference) do
    reference
      |> :erlang.ref_to_list()
      |> List.to_string()
      |> String.replace_prefix("#Ref<", "")
      |> String.replace_suffix(">", "")
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex-col">
      <h1>Listing Excel</h1>
      <%= for table <- @tables do %>
        <.link patch={"/excel/#{table}"}>Table: {table} </.link>
      <% end %>
    </div>
    """
  end

  @impl true
  def mount(params, _session, socket) do
    tables = Enum.to_list(0..4)
      |> (Enum.map &extract_table/1)
      |> (Enum.map &extract_table_id/1)
      |> (Enum.map &ref_to_string/1)

    {:ok, assign(socket, :tables, tables)}
  end

  @impl true
  def handle_params(params, url, socket) do
    if Map.has_key?(params, :id) do
      {:noreply, push_patch(socket, to: "/excel/#{Map.get(params, :id)}")}
    else
      {:noreply, socket}
    end
  end
end
