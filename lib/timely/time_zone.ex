defmodule Timely.TimeZone do
  @moduledoc """
  Provides time zone convenience functions.
  """

  def list do
      [
        "",
        utc()
      ]
      ++
      (Tzdata.canonical_zone_list()
      |> Enum.filter( fn(zone) -> String.starts_with?( zone, "America/" ) end))
  end

  def list( :usa, opts \\ [] ) do
    include_blank? = Keyword.get( opts, :include_blank?, false )

    zones = [
      utc(),
      est(),
      cst(),
      mst(),
      pst(),
      hst(),
      akst()
    ]

    if include_blank?,
      do: [""] ++ zones,
      else: zones
  end

  def gmt, do: "Etc/GMT"
  def utc, do: "Etc/UTC"

  def est, do: "America/New_York"
  def cst, do: "America/Chicago"
  def mst, do: "America/Denver"
  def pst, do: "America/Los_Angeles"
  def hst, do: "Pacific/Honolulu"
  def akst, do: "US/Alaska"

end
