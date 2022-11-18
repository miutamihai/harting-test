defmodule HartingWeb.ExcelLive.Show do
  use HartingWeb, :live_view

  defp get_list(table_id) do
    Xlsxir.get_list(table_id)
  end

  defp string_to_ref(table_id) do
    format_string = fn string -> '#Ref<#{string}>' end

    table_id
    |> format_string.()
    |> :erlang.list_to_ref()
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :rows, [])}
  end

  @impl true
  def handle_params(params, _url, socket) do
    table_id = Map.get(params, "id")
    reference = string_to_ref(table_id)
    rows = Xlsxir.get_list(reference)

    {:noreply, assign(socket, :rows, rows)}
  end

  @impl true
  def render(assigns) do
    ~H"""
      <div class="flex-col" style="padding-left: 40px; padding-right: 40px">
        <h1>Listing table</h1>
        <.link patch={"/excel"}>Go back</.link>
        <table style="max-width: 700px;">
          <%= for row <- @rows do %>
            <tr>
              <%= for col <- row do %>
                <td> <%= col %> </td>
              <% end %>
            </tr>
          <% end %>
        </table>
      </div>
    """
  end
end
