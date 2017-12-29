defmodule Timely do
  @moduledoc """
  Provides functions for converting, comparing and shifting Elixir date & times.
  """

  @type date_tuple     :: {integer, integer, integer}
  @type datetime_tuple :: {{integer, integer, integer}, {integer, integer, integer}}

  @type microseconds :: {integer, integer}

  @typedoc """
  A valid time zone.
  """
  @type time_zone :: binary

  @type date_or_time_like :: Date.t | DateTime.t | NaiveDateTime.t | Ecto.Date.t | Ecto.DateTime.t | String.t

  @typedoc """
  A known spec or a format string.
  """
  @type spec_or_format :: Atom.t | String.t

  @default_timezone  Timely.TimeZone.utc()
  @zero_microseconds {0,6}

  def ago(dt \\ utc(), units, scale) do
    case units do
      :seconds -> Timex.shift(dt, seconds: (scale * -1))
      :minutes -> Timex.shift(dt, minutes: (scale * -1))
      :hours   -> Timex.shift(dt, hours: (scale * -1))
      :days    -> Timex.shift(dt, days: (scale * -1))
      :months  -> Timex.shift(dt, months: (scale * -1))
      :years   -> Timex.shift(dt, years: (scale * -1))
    end
  end

  @doc """
  Initializes a DateTime.
  """
  @spec new_datetime(datetime_tuple, microseconds, time_zone) :: DateTime.t
  def new_datetime({{year, month, day}, {hour, minute, second}}, microseconds \\ @zero_microseconds, time_zone \\ @default_timezone) do
    %{abbreviation: abbr,
      offset_std: offset_std,
      offset_utc: offset_utc} = Timex.Timezone.get(time_zone)

    %DateTime{year: year, month: month, day: day, hour: hour, minute: minute,
              second: second, time_zone: time_zone, zone_abbr: abbr,
              utc_offset: offset_utc, std_offset: offset_std, microsecond: microseconds}
  end

  @doc """
  Converts common date time like date structures to other common date time like data structures.
  """
  @spec as(date_or_time_like | nil, spec_or_format) :: date_or_time_like | nil

  def as({:ok, dt}, format_or_spec),     do: as(dt, format_or_spec)
  def as({:error, _desc} = error, _any), do: error

  def as(nil, :date_tuple),     do: nil
  def as(nil, :datetime_tuple), do: nil
  def as(nil, :ecto_date),      do: nil
  def as(nil, :ecto_datetime),  do: nil
  def as(nil, :iso8601),        do: nil
  def as(nil, :iso8601_date),   do: nil
  def as(nil, :iso8601_z),      do: nil
  def as(nil, :rfc1123),        do: nil
  def as(nil, _spec),           do: nil

  def as(<<year::binary-size(4),
           month::binary-size(2),
           day::binary-size(2)>>, format_or_spec)
  do
    {year, month, day}
    |> convert_strings_to_integers
    |> as(format_or_spec)
  end

  def as(<<year::binary-size(4),
           "-",
           month::binary-size(2),
           "-",
           day::binary-size(2)>>, format_or_spec)
  do
    {year, month, day}
    |> convert_strings_to_integers
    |> as(format_or_spec)
  end

  def as(<<year::binary-size(4),
           "/",
           month::binary-size(2),
           "/",
           day::binary-size(2)>>, format_or_spec)
  do
    {year, month, day}
    |> convert_strings_to_integers
    |> as(format_or_spec)
  end

  def as(<<year::binary-size(4),
           ".",
           month::binary-size(2),
           ".",
           day::binary-size(2)>>, format_or_spec)
  do
    {year, month, day}
    |> convert_strings_to_integers
    |> as(format_or_spec)
  end

  def as(<<month::binary-size(2),
           "-",
           day::binary-size(2),
           "-",
           year::binary-size(4)>>, format_or_spec)
  do
    {year, month, day}
    |> convert_strings_to_integers
    |> as(format_or_spec)
  end

  def as(<<month::binary-size(2),
           "/",
           day::binary-size(2),
           "/",
           year::binary-size(4)>>, format_or_spec)
  do
    {year, month, day}
    |> convert_strings_to_integers
    |> as(format_or_spec)
  end

  def as(<<month::binary-size(2),
           ".",
           day::binary-size(2),
           ".",
           year::binary-size(4)>>, format_or_spec)
  do
    {year, month, day}
    |> convert_strings_to_integers
    |> as(format_or_spec)
  end

  def as(<<year::binary-size(4),
           "-",
           month::binary-size(2),
           "-",
           day::binary-size(2),
           "T",
           hour::binary-size(2),
           ":",
           minute::binary-size(2),
           ":",
           second::binary-size(2),
           "+",
           _offset::binary-size(4)>>, format_or_spec)
  do
    {{year, month, day}, {hour, minute, second}}
    |> convert_strings_to_integers
    |> as(format_or_spec)
  end

  def as(<<year::binary-size(4),
           "-",
           month::binary-size(2),
           "-",
           day::binary-size(2),
           "T",
           hour::binary-size(2),
           ":",
           minute::binary-size(2),
           ":",
           second::binary-size(2),
           "Z">>, format_or_spec)
  do
    {{year, month, day}, {hour, minute, second}}
    |> convert_strings_to_integers
    |> as(format_or_spec)
  end

  def as(<<year::binary-size(4),
           "-",
           month::binary-size(2),
           "-",
           day::binary-size(2),
           " ",
           hour::binary-size(2),
           ":",
           minute::binary-size(2),
           ":",
           second::binary-size(2)>>, format_or_spec)
  do
    {{year, month, day}, {hour, minute, second}}
    |> convert_strings_to_integers
    |> as(format_or_spec)
  end

  def as(<<year::binary-size(4),
           "/",
           month::binary-size(2),
           "/",
           day::binary-size(2),
           " ",
           hour::binary-size(2),
           ":",
           minute::binary-size(2),
           ":",
           second::binary-size(2)>>, format_or_spec)
  do
    {{year, month, day}, {hour, minute, second}}
    |> convert_strings_to_integers
    |> as(format_or_spec)
  end

  def as(<<_day_of_week::binary-size(3),
           ", ",
           day::binary-size(2),
           " ",
           month_as_str::binary-size(3),
           " ",
           year::binary-size(4),
           " ",
           hour::binary-size(2),
           ":",
           minute::binary-size(2),
           ":",
           second::binary-size(2),
           " +",
           _offset::binary-size(4)>>, format_or_spec)
  do
    month = Timex.month_to_num(month_as_str)

    {{year, "0#{month}", day}, {hour, minute, second}}
    |> convert_strings_to_integers
    |> as(format_or_spec)
  end

  def as(%Ecto.Date{year: year, month: month, day: day}, :date_tuple),     do: {year, month, day}
  def as(%Ecto.Date{year: year, month: month, day: day}, :datetime_tuple), do: {{year, month, day}, {0, 0, 0}}
  def as(%Ecto.Date{} = dt, :ecto_date),                                   do: dt

  def as(%Ecto.Date{year: year, month: month, day: day}, :ecto_datetime) do
    %Ecto.DateTime{year: year, month: month, day: day, hour: 0, min: 0, sec: 0}
  end

  def as(%Ecto.Date{} = dt, :date),         do: Ecto.Date.to_erl(dt) |> Date.from_erl() |> process_result_tuple()
  def as(%Ecto.Date{} = dt, :datetime),     do: new_datetime({Ecto.Date.to_erl(dt), {0, 0, 0}}, @zero_microseconds)
  def as(%Ecto.Date{} = dt, :iso8601),      do: as(dt, :datetime) |> as(:iso8601)
  def as(%Ecto.Date{} = dt, :iso8601_date), do: as(dt, :date) |> as(:iso8601_date)
  def as(%Ecto.Date{} = dt, :iso8601_z),    do: as(dt, :date) |> as(:iso8601_z)
  def as(%Ecto.Date{} = dt, :rfc1123),      do: as(dt, :date) |> as(:rfc1123)
  def as(%Ecto.Date{} = dt, spec),          do:  as(dt, :date) |> as(spec)

  def as(%Ecto.DateTime{year: year, month: month, day: day}, :date_tuple),                                     do: {year, month, day}
  def as(%Ecto.DateTime{year: year, month: month, day: day, hour: hour, min: min, sec: sec}, :datetime_tuple), do: {{year, month, day}, {hour, min, sec}}

  def as(%Ecto.DateTime{} = dt, :ecto_date),     do: Ecto.Date.cast!(dt)
  def as(%Ecto.DateTime{} = dt, :ecto_datetime), do: dt
  def as(%Ecto.DateTime{} = dt, :date),          do: Ecto.DateTime.to_date(dt) |> Ecto.Date.to_erl |> as(:date)
  def as(%Ecto.DateTime{} = dt, :datetime),      do: new_datetime(Ecto.DateTime.to_erl(dt), @zero_microseconds)
  def as(%Ecto.DateTime{} = dt, :iso8601),       do: Ecto.DateTime.to_erl(dt) |> as(:iso8601)
  def as(%Ecto.DateTime{} = dt, :iso8601_date),  do: Ecto.DateTime.to_erl(dt) |> as(:iso8601_date)
  def as(%Ecto.DateTime{} = dt, :iso8601_z),     do: Ecto.DateTime.to_erl(dt) |> as(:iso8601_z)
  def as(%Ecto.DateTime{} = dt, :rfc1123),       do: new_datetime(Ecto.DateTime.to_erl(dt), @zero_microseconds) |> as(:rfc1123)
  def as(%Ecto.DateTime{} = dt, :timestamp),     do: as(dt, "%Y%m%d%H%M%S")
  def as(%Ecto.DateTime{} = dt, spec),           do: Ecto.DateTime.to_erl(dt) |> as(spec)

  def as(%Date{} = dt, :date_tuple),     do: Date.to_erl(dt) |> as(:date_tuple)
  def as(%Date{} = dt, :datetime_tuple), do: Date.to_erl(dt) |> as(:datetime_tuple)
  def as(%Date{} = dt, :date),           do: dt
  def as(%Date{} = dt, :datetime),       do: Date.to_erl(dt) |> as(:datetime)
  def as(%Date{} = dt, :ecto_date),      do: Date.to_erl(dt) |> as(:ecto_date)
  def as(%Date{} = dt, :ecto_datetime),  do: Date.to_erl(dt) |> as(:ecto_datetime)
  def as(%Date{} = dt, :iso8601),        do: dt |> as(:datetime) |> Timex.format!("{ISO:Extended}")
  def as(%Date{} = dt, :iso8601_date),   do: Timex.format!(dt, "{ISOdate}")
  def as(%Date{} = dt, :iso8601_z),      do: Timex.format!(dt, "{ISO:Extended:Z}")
  def as(%Date{} = dt, :naive_datetime), do: {Date.to_erl(dt),{0,0,0}} |> NaiveDateTime.from_erl(@zero_microseconds) |> process_result_tuple()
  def as(%Date{} = dt, :rfc1123),        do: dt |> as(:datetime) |> Timex.format!("{RFC1123}") |> String.trim()
  def as(%Date{} = dt, :timestamp),      do: as(dt, "%Y%m%d%H%M%S")
  def as(%Date{} = dt, spec),            do: strftime(dt, spec)

  def as(%DateTime{} = dt, :date_tuple),     do: DateTime.to_naive(dt) |> NaiveDateTime.to_erl |> as(:date_tuple)
  def as(%DateTime{} = dt, :datetime_tuple), do: DateTime.to_naive(dt) |> NaiveDateTime.to_erl |> as(:datetime_tuple)
  def as(%DateTime{} = dt, :date),           do: DateTime.to_naive(dt) |> NaiveDateTime.to_erl |> as(:date)
  def as(%DateTime{} = dt, :datetime),       do: dt
  def as(%DateTime{} = dt, :ecto_date),      do: DateTime.to_naive(dt) |> NaiveDateTime.to_erl |> as(:ecto_date)
  def as(%DateTime{} = dt, :ecto_datetime),  do: DateTime.to_naive(dt) |> NaiveDateTime.to_erl |> as(:ecto_datetime)
  def as(%DateTime{} = dt, :iso8601),        do: Timex.format!(dt, "{ISO:Extended}")
  def as(%DateTime{} = dt, :iso8601_date),   do: strftime(dt, "%Y-%m-%d")
  def as(%DateTime{} = dt, :iso8601_z),      do: Timex.format!(dt, "{ISO:Extended:Z}")
  def as(%DateTime{} = dt, :naive_datetime), do: DateTime.to_naive(dt)
  def as(%DateTime{} = dt, :rfc1123),        do: Timex.format!(dt, "{RFC1123}") |> String.trim
  def as(%DateTime{} = dt, :timestamp),      do: as(dt, "%Y%m%d%H%M%S")
  def as(%DateTime{} = dt, spec),            do: strftime(dt, spec)

  def as(%NaiveDateTime{} = dt, :date_tuple),     do: NaiveDateTime.to_erl(dt) |> as(:date_tuple)
  def as(%NaiveDateTime{} = dt, :datetime_tuple), do: NaiveDateTime.to_erl(dt) |> as(:datetime_tuple)
  def as(%NaiveDateTime{} = dt, :date),           do: NaiveDateTime.to_erl(dt) |> as(:date)
  def as(%NaiveDateTime{} = dt, :datetime),       do: NaiveDateTime.to_erl(dt) |> as(:datetime)
  def as(%NaiveDateTime{} = dt, :ecto_date),      do: NaiveDateTime.to_erl(dt) |> as(:ecto_date)
  def as(%NaiveDateTime{} = dt, :ecto_datetime),  do: NaiveDateTime.to_erl(dt) |> as(:ecto_datetime)
  def as(%NaiveDateTime{} = dt, :iso8601),        do: dt |> as(:datetime) |> Timex.format!("{ISO:Extended}")
  def as(%NaiveDateTime{} = dt, :iso8601_date),   do: strftime(dt, "%Y-%m-%d")
  def as(%NaiveDateTime{} = dt, :iso8601_z),      do: Timex.format!(dt, "{ISO:Extended:Z}")
  def as(%NaiveDateTime{} = dt, :naive_datetime), do: dt
  def as(%NaiveDateTime{} = dt, :rfc1123),        do: dt |> as(:datetime) |> Timex.format!("{RFC1123}") |> String.trim()
  def as(%NaiveDateTime{} = dt, :timestamp),      do: as(dt, "%Y%m%d%H%M%S")
  def as(%NaiveDateTime{} = dt, spec),            do: strftime(dt, spec)

  def as({:strftime, dt, spec}, format), do: dt |> Timex.parse!(spec, :strftime) |> as(format)

  def as({{year, month, day}, {_,_,_}}, :date_tuple),                do: {year, month, day}
  def as({{_,_,_}, {_,_,_}} = dt, :datetime_tuple),                  do: dt
  def as({{_,_,_}, {_,_,_}} = {erl, _}, :date),                      do: Date.from_erl(erl) |> process_result_tuple()
  def as({{_,_,_}, {_,_,_}} = dt, :datetime),                        do: new_datetime(dt, @zero_microseconds)
  def as({{year, month, day}, {_,_,_}}, :ecto_date),                 do: %Ecto.Date{year: year, month: month, day: day}
  def as({{_,_,_}, {_,_,_}} = dt, :ecto_datetime),                   do: Ecto.DateTime.from_erl(dt)
  def as({{_,_,_}, {_,_,_}} = dt, :iso8601),                         do: new_datetime(dt, @zero_microseconds) |> as(:iso8601)
  def as({{_,_,_}, {_,_,_}, {_,_} = microseconds} = dt, :iso8601),   do: new_datetime(dt, microseconds) |> as(:iso8601)
  def as({{_,_,_}, {_,_,_}} = {erl, _}, :iso8601_date),              do: Date.from_erl(erl) |> process_result_tuple() |> as(:iso8601_date)
  def as({{_,_,_}, {_,_,_}} = dt, :iso8601_z),                       do: new_datetime(dt, @zero_microseconds) |> as(:iso8601_z)
  def as({{_,_,_}, {_,_,_}, {_,_} = microseconds} = dt, :iso8601_z), do: new_datetime(dt, microseconds) |> as(:iso8601_z)
  def as({{_,_,_}, {_,_,_}} = dt, :naive_datetime),                  do: NaiveDateTime.from_erl(dt, @zero_microseconds) |> process_result_tuple()
  def as({{_,_,_}, {_,_,_}} = dt, :rfc1123),                         do: new_datetime(dt) |> as(:rfc1123)
  def as({{_,_,_}, {_,_,_}} = dt, spec),                             do: new_datetime(dt) |> as(spec)

  def as({_,_,_} = dt, :date_tuple),     do: dt
  def as({_,_,_} = dt, :datetime_tuple), do: {dt, {0, 0, 0}}
  def as({_,_,_} = dt, :date),           do: Date.from_erl(dt) |> process_result_tuple()
  def as({_,_,_} = dt, :datetime),       do: new_datetime(as(dt, :datetime_tuple))
  def as({_,_,_} = dt, :ecto_date),      do: Ecto.Date.from_erl(dt)
  def as({_,_,_} = dt, :ecto_datetime),  do: Ecto.DateTime.from_erl({dt, {0,0,0}})
  def as({_,_,_} = dt, :iso8601),        do: as(dt, :datetime) |> as(:iso8601)
  def as({_,_,_} = dt, :iso8601_date),   do: as(dt, :date) |> as(:iso8601_date)
  def as({_,_,_} = dt, :iso8601_z),      do: as(dt, :date) |> as(:iso8601_z)
  def as({_,_,_} = dt, :naive_datetime), do: NaiveDateTime.from_erl({dt,{0,0,0}}, @zero_microseconds) |> process_result_tuple()
  def as({_,_,_} = dt, :rfc1123),        do: as(dt, :date) |> as(:rfc1123)
  def as({_,_,_} = dt, spec),            do: as(dt, :date) |> as(spec)

  def as(_any, _spec), do: {:error, :invalid_date}

  def from_now(dt \\ utc(), units, scale) do
    case units do
      :seconds -> Timex.shift(dt, secs: scale)
      :minutes -> Timex.shift(dt, mins: scale)
      :hours   -> Timex.shift(dt, hours: scale)
      :days    -> Timex.shift(dt, days: scale)
      :months  -> Timex.shift(dt, months: scale)
      :years   -> Timex.shift(dt, years: scale)
    end
  end

  def now_in_timezone,           do: now_in_timezone(@default_timezone)
  def now_in_timezone(timezone), do: Timex.now(timezone)

  def in_timezone(nil, _timezone),                   do: nil
  def in_timezone(%DateTime{} = datetime, timezone), do: Timex.Timezone.convert(datetime, timezone)

  def utc, do: Timex.now()

  def utc_today, do: DateTime.to_date(utc())

  def after?(%DateTime{} = dt1, %DateTime{} = dt2), do: Timex.after?(dt1, dt2)

  def after?(dt1, dt2) do
    dt1 = as(dt1, :naive_datetime)
    dt2 = as(dt2, :naive_datetime)
    Timex.after?(dt1, dt2)
  end

  def before?(%DateTime{} = dt1, %DateTime{} = dt2), do: Timex.before?(dt1, dt2)

  def before?(dt1, dt2) do
    dt1 = as(dt1, :naive_datetime)
    dt2 = as(dt2, :naive_datetime)
    Timex.before?(dt1, dt2)
  end

  def before_or_on?(%DateTime{} = dt1, %DateTime{} = dt2) do
    Timex.before?(dt1, dt2) || Timex.equal?(dt1, dt2)
  end

  def before_or_on?(dt1, dt2) do
    dt1 = as(dt1, :naive_datetime)
    dt2 = as(dt2, :naive_datetime)
    Timex.before?(dt1, dt2) || Timex.equal?(dt1, dt2)
  end

  def on_or_after?(%DateTime{} = dt1, %DateTime{} = dt2) do
    Timex.after?(dt1, dt2) || Timex.equal?(dt1, dt2)
  end

  def on_or_after?(dt1, dt2) do
    dt1 = as(dt1, :naive_datetime)
    dt2 = as(dt2, :naive_datetime)
    Timex.after?(dt1, dt2) || Timex.equal?(dt1, dt2)
  end

  def equal?(%DateTime{} = dt1, %DateTime{} = dt2), do: Timex.equal?(dt1, dt2)

  def equal?(dt1, dt2) do
    dt1 = as(dt1, :naive_datetime)
    dt2 = as(dt2, :naive_datetime)
    Timex.equal?(dt1, dt2)
  end

  # Private ##########

  defp convert_strings_to_integers({year, month, day}) do
    {year, _}   = Integer.parse(year)
    {month, _}  = Integer.parse(month)
    {day, _}    = Integer.parse(day)

    {year, month, day}
  end

  defp convert_strings_to_integers({{year, month, day}, {hour, minute, second}}) do
    {year, _}   = Integer.parse(year)
    {month, _}  = Integer.parse(month)
    {day, _}    = Integer.parse(day)
    {hour, _}   = Integer.parse(hour)
    {minute, _} = Integer.parse(minute)
    {second, _} = Integer.parse(second)

    {{year, month, day}, {hour, minute, second}}
  end

  defp strftime(dt, format), do: Timex.format!(dt, format, :strftime)

  defp process_result_tuple({:ok, result}), do: result
  defp process_result_tuple(any),           do: any

end
