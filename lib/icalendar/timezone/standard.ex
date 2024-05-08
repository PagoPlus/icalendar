defmodule ICalendar.Timezone.Standard do
  @moduledoc """
  Timezone has standard time
  """
  defstruct tzoffsetfrom: nil,
            tzoffsetto: nil,
            tzname: nil,
            rrule: nil

  @type t :: %__MODULE__{
          tzoffsetfrom: integer(),
          tzoffsetto: integer(),
          tzname: String.t(),
          rrule: map()
        }

  defimpl ICalendar.Serialize, for: ICalendar.Timezone.Standard do
    alias ICalendar.Util.KV

    def to_ics(%ICalendar.Timezone.Standard{} = standard, _options \\ []) do
      contents = to_kvs(standard)

      """
      BEGIN:STANDARD
      #{contents}END:STANDARD
      """
    end

    defp to_kvs(standard) do
      standard
      |> Map.from_struct()
      |> Enum.map(&to_kv/1)
      |> List.flatten()
      |> Enum.sort()
      |> Enum.join()
    end

    defp to_kv({key, value}) do
      name = key |> to_string |> String.upcase()
      KV.build(name, value)
    end
  end
end
