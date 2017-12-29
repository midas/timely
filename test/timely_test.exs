defmodule Timely.TimelyTest do

  use ExUnit.Case, async: true

  describe "as/2 when providing nil" do

    setup do
      {:ok, %{date: nil}}
    end

    test "should be able to convert it to an :date_tuple", %{date: date} do
      assert is_nil(Timely.as(date, :date_tuple))
    end

    test "should be able to convert it to an :datetime_tuple", %{date: date} do
      assert is_nil(Timely.as(date, :datetime_tuple))
    end

    test "should be able to convert it to an :date", %{date: date} do
      assert is_nil(Timely.as(date, :date))
    end

    test "should be able to convert it to an :datetime", %{date: date} do
      assert is_nil(Timely.as(date, :datetime))
    end

    test "should be able to convert it to an :ecto_date", %{date: date} do
      assert is_nil(Timely.as(date, :ecto_date))
    end

    test "should be able to convert it to an :ecto_datetime", %{date: date} do
      assert is_nil(Timely.as(date, :ecto_datetime))
    end

    test "should be able to convert it to an :iso8601", %{date: date} do
      assert is_nil(Timely.as(date, :iso8601))
    end

    test "should be able to convert it to an :iso8601_date", %{date: date} do
      assert is_nil(Timely.as(date, :iso8601_date))
    end

    test "should be able to convert it to an :iso8601_z", %{date: date} do
      assert is_nil(Timely.as(date, :iso8601_z))
    end

    test "should be able to convert it to an :naive_datetime", %{date: date} do
      assert is_nil(Timely.as(date, :naive_datetime))
    end

    test "should be able to convert it to an :rfc1123", %{date: date} do
      assert is_nil(Timely.as(date, :rfc1123))
    end

    test "should be able to convert it to an :strftime", %{date: date} do
      assert is_nil(Timely.as(date, "%Y-%m-%d---%H:%M:%S"))
    end

  end

  describe "as/2 when providing a date tuple" do

    setup do
      {:ok, %{date: {2000, 1, 1}}}
    end

    test "should be able to convert it to an :date_tuple", %{date: date} do
      assert Timely.as(date, :date_tuple) == {2000, 1, 1}
    end

    test "should be able to convert it to an :datetime_tuple", %{date: date} do
      assert Timely.as(date, :datetime_tuple) == {{2000, 1, 1}, {0, 0, 0}}
    end

    test "should be able to convert it to an :date", %{date: date} do
      assert Timely.as(date, :date) == Date.from_erl!({2000, 1, 1})
    end

    #test "should be able to convert it to an :datetime", %{date: date} do
      #{:ok, datetime, 0} = DateTime.from_iso8601("2000-01-01T00:00:00Z")
      #assert Timely.as(date, :datetime) == datetime
    #end

    test "should be able to convert it to an :ecto_date", %{date: date} do
      assert Timely.as(date, :ecto_date) == Ecto.Date.from_erl({2000, 1, 1})
    end

    test "should be able to convert it to an :ecto_datetime", %{date: date} do
      assert Timely.as(date, :ecto_datetime) == Ecto.DateTime.from_erl({{2000, 1, 1}, {0, 0, 0}})
    end

    test "should be able to convert it to an :iso8601", %{date: date} do
      assert Timely.as(date, :iso8601) == "2000-01-01T00:00:00.000000+00:00"
    end

    test "should be able to convert it to an :iso8601_date", %{date: date} do
      assert Timely.as(date, :iso8601_date) == "2000-01-01"
    end

    test "should be able to convert it to an :iso8601_z", %{date: date} do
      assert Timely.as(date, :iso8601_z) == "2000-01-01T00:00:00Z"
    end

    test "should be able to convert it to an :naive_datetime", %{date: date} do
      assert Timely.as(date, :naive_datetime) == ~N[2000-01-01 00:00:00.000000]
    end

    test "should be able to convert it to an :rfc1123", %{date: date} do
      assert Timely.as(date, :rfc1123) == "Sat, 01 Jan 2000 00:00:00 +0000"
    end

    test "should be able to convert it to an :strftime", %{date: date} do
      assert Timely.as(date, "%Y-%m-%d---%H:%M:%S") == "2000-01-01---00:00:00"
    end

  end

  describe "as/2 when providing a Date" do

    setup do
      {:ok, %{date: ~D[2000-01-01]}}
    end

    test "should be able to convert it to an :date_tuple", %{date: date} do
      assert Timely.as(date, :date_tuple) == {2000, 1, 1}
    end

    test "should be able to convert it to an :datetime_tuple", %{date: date} do
      assert Timely.as(date, :datetime_tuple) == {{2000, 1, 1}, {0, 0, 0}}
    end

    test "should be able to convert it to an :date", %{date: date} do
      assert Timely.as(date, :date) == Date.from_erl!({2000, 1, 1})
    end

    #test "should be able to convert it to an :datetime", %{date: date} do
      #{:ok, datetime, 0} = DateTime.from_iso8601("2000-01-01T00:00:00Z")
      #assert Timely.as(date, :datetime) == datetime
    #end

    test "should be able to convert it to an :ecto_date", %{date: date} do
      assert Timely.as(date, :ecto_date) == Ecto.Date.from_erl({2000, 1, 1})
    end

    test "should be able to convert it to an :ecto_datetime", %{date: date} do
      assert Timely.as(date, :ecto_datetime) == Ecto.DateTime.from_erl({{2000, 1, 1}, {0, 0, 0}})
    end

    test "should be able to convert it to an :iso8601", %{date: date} do
      assert Timely.as(date, :iso8601) == "2000-01-01T00:00:00.000000+00:00"
    end

    test "should be able to convert it to an :iso8601_date", %{date: date} do
      assert Timely.as(date, :iso8601_date) == "2000-01-01"
    end

    test "should be able to convert it to an :iso8601_z", %{date: date} do
      assert Timely.as(date, :iso8601_z) == "2000-01-01T00:00:00Z"
    end

    test "should be able to convert it to an :naive_datetime", %{date: date} do
      assert Timely.as(date, :naive_datetime) == ~N[2000-01-01 00:00:00.000000]
    end

    test "should be able to convert it to an :rfc1123", %{date: date} do
      assert Timely.as(date, :rfc1123) == "Sat, 01 Jan 2000 00:00:00 +0000"
    end

    test "should be able to convert it to an :strftime", %{date: date} do
      assert Timely.as(date, "%Y-%m-%d---%H:%M:%S") == "2000-01-01---00:00:00"
    end

  end

  describe "as/2 when providing a DateTime" do

    setup do
      {:ok, datetime, 0} = DateTime.from_iso8601("2000-01-01T00:00:00Z")
      {:ok, %{date: datetime}}
    end

    test "should be able to convert it to an :date_tuple", %{date: date} do
      assert Timely.as(date, :date_tuple) == {2000, 1, 1}
    end

    test "should be able to convert it to an :datetime_tuple", %{date: date} do
      assert Timely.as(date, :datetime_tuple) == {{2000, 1, 1}, {0, 0, 0}}
    end

    test "should be able to convert it to an :date", %{date: date} do
      assert Timely.as(date, :date) == Date.from_erl!({2000, 1, 1})
    end

    test "should be able to convert it to an :datetime", %{date: date} do
      {:ok, datetime, 0} = DateTime.from_iso8601("2000-01-01T00:00:00Z")
      assert Timely.as(date, :datetime) == datetime
    end

    test "should be able to convert it to an :ecto_date", %{date: date} do
      assert Timely.as(date, :ecto_date) == Ecto.Date.from_erl({2000, 1, 1})
    end

    test "should be able to convert it to an :ecto_datetime", %{date: date} do
      assert Timely.as(date, :ecto_datetime) == Ecto.DateTime.from_erl({{2000, 1, 1}, {0, 0, 0}})
    end

    test "should be able to convert it to an :iso8601", %{date: date} do
      assert Timely.as(date, :iso8601) == "2000-01-01T00:00:00+00:00"
    end

    test "should be able to convert it to an :iso8601_date", %{date: date} do
      assert Timely.as(date, :iso8601_date) == "2000-01-01"
    end

    test "should be able to convert it to an :iso8601_z", %{date: date} do
      assert Timely.as(date, :iso8601_z) == "2000-01-01T00:00:00Z"
    end

    #test "should be able to convert it to an :naive_datetime", %{date: date} do
      #assert Timely.as(date, :naive_datetime) == ~N[2000-01-01 00:00:00.000000]
    #end

    test "should be able to convert it to an :rfc1123", %{date: date} do
      assert Timely.as(date, :rfc1123) == "Sat, 01 Jan 2000 00:00:00 +0000"
    end

    test "should be able to convert it to an :strftime", %{date: date} do
      assert Timely.as(date, "%Y-%m-%d---%H:%M:%S") == "2000-01-01---00:00:00"
    end

  end

  describe "as/2 when providing an Ecto.Date" do

    setup do
      {:ok, %{date: Ecto.Date.from_erl({2000, 1, 1})}}
    end

    test "should be able to convert it to an :date_tuple", %{date: date} do
      assert Timely.as(date, :date_tuple) == {2000, 1, 1}
    end

    test "should be able to convert it to an :datetime_tuple", %{date: date} do
      assert Timely.as(date, :datetime_tuple) == {{2000, 1, 1}, {0, 0, 0}}
    end

    test "should be able to convert it to an :date", %{date: date} do
      assert Timely.as(date, :date) == Date.from_erl!({2000, 1, 1})
    end

    #test "should be able to convert it to an :datetime", %{date: date} do
      #{:ok, datetime, 0} = DateTime.from_iso8601("2000-01-01T00:00:00Z")
      #assert Timely.as(date, :datetime) == datetime
    #end

    test "should be able to convert it to an :ecto_date", %{date: date} do
      assert Timely.as(date, :ecto_date) == Ecto.Date.from_erl({2000, 1, 1})
    end

    test "should be able to convert it to an :ecto_datetime", %{date: date} do
      assert Timely.as(date, :ecto_datetime) == Ecto.DateTime.from_erl({{2000, 1, 1}, {0, 0, 0}})
    end

    test "should be able to convert it to an :iso8601", %{date: date} do
      assert Timely.as(date, :iso8601) == "2000-01-01T00:00:00.000000+00:00"
    end

    test "should be able to convert it to an :iso8601_date", %{date: date} do
      assert Timely.as(date, :iso8601_date) == "2000-01-01"
    end

    test "should be able to convert it to an :iso8601_z", %{date: date} do
      assert Timely.as(date, :iso8601_z) == "2000-01-01T00:00:00Z"
    end

    test "should be able to convert it to an :naive_datetime", %{date: date} do
      assert Timely.as(date, :naive_datetime) == ~N[2000-01-01 00:00:00.000000]
    end

    test "should be able to convert it to an :rfc1123", %{date: date} do
      assert Timely.as(date, :rfc1123) == "Sat, 01 Jan 2000 00:00:00 +0000"
    end

    test "should be able to convert it to an :strftime", %{date: date} do
      assert Timely.as(date, "%Y-%m-%d---%H:%M:%S") == "2000-01-01---00:00:00"
    end

  end

  describe "as/2 when providing an Ecto.DateTime" do

    setup do
      {:ok, %{date: Ecto.DateTime.from_erl({{2000, 1, 1}, {0, 0, 0}})}}
    end

    test "should be able to convert it to an :date_tuple", %{date: date} do
      assert Timely.as(date, :date_tuple) == {2000, 1, 1}
    end

    test "should be able to convert it to an :datetime_tuple", %{date: date} do
      assert Timely.as(date, :datetime_tuple) == {{2000, 1, 1}, {0, 0, 0}}
    end

    test "should be able to convert it to an :date", %{date: date} do
      assert Timely.as(date, :date) == Date.from_erl!({2000, 1, 1})
    end

    #test "should be able to convert it to an :datetime", %{date: date} do
      #{:ok, datetime, 0} = DateTime.from_iso8601("2000-01-01T00:00:00Z")
      #assert Timely.as(date, :datetime) == datetime
    #end

    test "should be able to convert it to an :ecto_date", %{date: date} do
      assert Timely.as(date, :ecto_date) == Ecto.Date.from_erl({2000, 1, 1})
    end

    test "should be able to convert it to an :ecto_datetime", %{date: date} do
      assert Timely.as(date, :ecto_datetime) == Ecto.DateTime.from_erl({{2000, 1, 1}, {0, 0, 0}})
    end

    test "should be able to convert it to an :iso8601", %{date: date} do
      assert Timely.as(date, :iso8601) == "2000-01-01T00:00:00.000000+00:00"
    end

    test "should be able to convert it to an :iso8601_date", %{date: date} do
      assert Timely.as(date, :iso8601_date) == "2000-01-01"
    end

    test "should be able to convert it to an :iso8601_z", %{date: date} do
      assert Timely.as(date, :iso8601_z) == "2000-01-01T00:00:00.000000Z"
    end

    test "should be able to convert it to an :naive_datetime", %{date: date} do
      assert Timely.as(date, :naive_datetime) == ~N[2000-01-01 00:00:00.000000]
    end

    test "should be able to convert it to an :rfc1123", %{date: date} do
      assert Timely.as(date, :rfc1123) == "Sat, 01 Jan 2000 00:00:00 +0000"
    end

    test "should be able to convert it to an :strftime", %{date: date} do
      assert Timely.as(date, "%Y-%m-%d---%H:%M:%S") == "2000-01-01---00:00:00"
    end

  end

  describe "as/2 when providing a NaiveDateTime" do

    setup do
      {:ok, %{date: NaiveDateTime.from_erl!({{2000, 1, 1}, {0, 0, 0}})}}
    end

    test "should be able to convert it to an :date_tuple", %{date: date} do
      assert Timely.as(date, :date_tuple) == {2000, 1, 1}
    end

    test "should be able to convert it to an :datetime_tuple", %{date: date} do
      assert Timely.as(date, :datetime_tuple) == {{2000, 1, 1}, {0, 0, 0}}
    end

    test "should be able to convert it to an :date", %{date: date} do
      assert Timely.as(date, :date) == Date.from_erl!({2000, 1, 1})
    end

    #test "should be able to convert it to an :datetime", %{date: date} do
      #{:ok, datetime, 0} = DateTime.from_iso8601("2000-01-01T00:00:00Z")
      #assert Timely.as(date, :datetime) == datetime
    #end

    test "should be able to convert it to an :ecto_date", %{date: date} do
      assert Timely.as(date, :ecto_date) == Ecto.Date.from_erl({2000, 1, 1})
    end

    test "should be able to convert it to an :ecto_datetime", %{date: date} do
      assert Timely.as(date, :ecto_datetime) == Ecto.DateTime.from_erl({{2000, 1, 1}, {0, 0, 0}})
    end

    test "should be able to convert it to an :iso8601", %{date: date} do
      assert Timely.as(date, :iso8601) == "2000-01-01T00:00:00.000000+00:00"
    end

    test "should be able to convert it to an :iso8601_date", %{date: date} do
      assert Timely.as(date, :iso8601_date) == "2000-01-01"
    end

    test "should be able to convert it to an :iso8601_z", %{date: date} do
      assert Timely.as(date, :iso8601_z) == "2000-01-01T00:00:00Z"
    end

    #test "should be able to convert it to an :naive_datetime", %{date: date} do
      #assert Timely.as(date, :naive_datetime) == ~N[2000-01-01 00:00:00.000000]
    #end

    test "should be able to convert it to an :rfc1123", %{date: date} do
      assert Timely.as(date, :rfc1123) == "Sat, 01 Jan 2000 00:00:00 +0000"
    end

    test "should be able to convert it to an :strftime", %{date: date} do
      assert Timely.as(date, "%Y-%m-%d---%H:%M:%S") == "2000-01-01---00:00:00"
    end

  end

  describe "as/2 when providing a string `20000101`" do

    setup do
      {:ok, %{date: "20000101"}}
    end

    test "should be able to convert it to an :date_tuple", %{date: date} do
      assert Timely.as(date, :date_tuple) == {2000, 1, 1}
    end

    test "should be able to convert it to an :datetime_tuple", %{date: date} do
      assert Timely.as(date, :datetime_tuple) == {{2000, 1, 1}, {0, 0, 0}}
    end

    test "should be able to convert it to an :date", %{date: date} do
      assert Timely.as(date, :date) == Date.from_erl!({2000, 1, 1})
    end

    #test "should be able to convert it to an :datetime", %{date: date} do
      #{:ok, datetime, 0} = DateTime.from_iso8601("2000-01-01T00:00:00Z")
      #assert Timely.as(date, :datetime) == datetime
    #end

    test "should be able to convert it to an :ecto_date", %{date: date} do
      assert Timely.as(date, :ecto_date) == Ecto.Date.from_erl({2000, 1, 1})
    end

    test "should be able to convert it to an :ecto_datetime", %{date: date} do
      assert Timely.as(date, :ecto_datetime) == Ecto.DateTime.from_erl({{2000, 1, 1}, {0, 0, 0}})
    end

    test "should be able to convert it to an :iso8601", %{date: date} do
      assert Timely.as(date, :iso8601) == "2000-01-01T00:00:00.000000+00:00"
    end

    test "should be able to convert it to an :iso8601_date", %{date: date} do
      assert Timely.as(date, :iso8601_date) == "2000-01-01"
    end

    test "should be able to convert it to an :iso8601_z", %{date: date} do
      assert Timely.as(date, :iso8601_z) == "2000-01-01T00:00:00Z"
    end

    test "should be able to convert it to an :naive_datetime", %{date: date} do
      assert Timely.as(date, :naive_datetime) == ~N[2000-01-01 00:00:00.000000]
    end

    test "should be able to convert it to an :rfc1123", %{date: date} do
      assert Timely.as(date, :rfc1123) == "Sat, 01 Jan 2000 00:00:00 +0000"
    end

    test "should be able to convert it to an :strftime", %{date: date} do
      assert Timely.as(date, "%Y-%m-%d---%H:%M:%S") == "2000-01-01---00:00:00"
    end

  end

  describe "as/2 when providing a string `2000/01/01`" do

    setup do
      {:ok, %{date: "2000/01/01"}}
    end

    test "should be able to convert it to an :date_tuple", %{date: date} do
      assert Timely.as(date, :date_tuple) == {2000, 1, 1}
    end

    test "should be able to convert it to an :datetime_tuple", %{date: date} do
      assert Timely.as(date, :datetime_tuple) == {{2000, 1, 1}, {0, 0, 0}}
    end

    test "should be able to convert it to an :date", %{date: date} do
      assert Timely.as(date, :date) == Date.from_erl!({2000, 1, 1})
    end

    #test "should be able to convert it to an :datetime", %{date: date} do
      #{:ok, datetime, 0} = DateTime.from_iso8601("2000-01-01T00:00:00Z")
      #assert Timely.as(date, :datetime) == datetime
    #end

    test "should be able to convert it to an :ecto_date", %{date: date} do
      assert Timely.as(date, :ecto_date) == Ecto.Date.from_erl({2000, 1, 1})
    end

    test "should be able to convert it to an :ecto_datetime", %{date: date} do
      assert Timely.as(date, :ecto_datetime) == Ecto.DateTime.from_erl({{2000, 1, 1}, {0, 0, 0}})
    end

    test "should be able to convert it to an :iso8601", %{date: date} do
      assert Timely.as(date, :iso8601) == "2000-01-01T00:00:00.000000+00:00"
    end

    test "should be able to convert it to an :iso8601_date", %{date: date} do
      assert Timely.as(date, :iso8601_date) == "2000-01-01"
    end

    test "should be able to convert it to an :iso8601_z", %{date: date} do
      assert Timely.as(date, :iso8601_z) == "2000-01-01T00:00:00Z"
    end

    test "should be able to convert it to an :naive_datetime", %{date: date} do
      assert Timely.as(date, :naive_datetime) == ~N[2000-01-01 00:00:00.000000]
    end

    test "should be able to convert it to an :rfc1123", %{date: date} do
      assert Timely.as(date, :rfc1123) == "Sat, 01 Jan 2000 00:00:00 +0000"
    end

    test "should be able to convert it to an :strftime", %{date: date} do
      assert Timely.as(date, "%Y-%m-%d---%H:%M:%S") == "2000-01-01---00:00:00"
    end

  end

  describe "as/2 when providing a string `2000-01-01`" do

    setup do
      {:ok, %{date: "2000-01-01"}}
    end

    test "should be able to convert it to an :date_tuple", %{date: date} do
      assert Timely.as(date, :date_tuple) == {2000, 1, 1}
    end

    test "should be able to convert it to an :datetime_tuple", %{date: date} do
      assert Timely.as(date, :datetime_tuple) == {{2000, 1, 1}, {0, 0, 0}}
    end

    test "should be able to convert it to an :date", %{date: date} do
      assert Timely.as(date, :date) == Date.from_erl!({2000, 1, 1})
    end

    #test "should be able to convert it to an :datetime", %{date: date} do
      #{:ok, datetime, 0} = DateTime.from_iso8601("2000-01-01T00:00:00Z")
      #assert Timely.as(date, :datetime) == datetime
    #end

    test "should be able to convert it to an :ecto_date", %{date: date} do
      assert Timely.as(date, :ecto_date) == Ecto.Date.from_erl({2000, 1, 1})
    end

    test "should be able to convert it to an :ecto_datetime", %{date: date} do
      assert Timely.as(date, :ecto_datetime) == Ecto.DateTime.from_erl({{2000, 1, 1}, {0, 0, 0}})
    end

    test "should be able to convert it to an :iso8601", %{date: date} do
      assert Timely.as(date, :iso8601) == "2000-01-01T00:00:00.000000+00:00"
    end

    test "should be able to convert it to an :iso8601_date", %{date: date} do
      assert Timely.as(date, :iso8601_date) == "2000-01-01"
    end

    test "should be able to convert it to an :iso8601_z", %{date: date} do
      assert Timely.as(date, :iso8601_z) == "2000-01-01T00:00:00Z"
    end

    test "should be able to convert it to an :naive_datetime", %{date: date} do
      assert Timely.as(date, :naive_datetime) == ~N[2000-01-01 00:00:00.000000]
    end

    test "should be able to convert it to an :rfc1123", %{date: date} do
      assert Timely.as(date, :rfc1123) == "Sat, 01 Jan 2000 00:00:00 +0000"
    end

    test "should be able to convert it to an :strftime", %{date: date} do
      assert Timely.as(date, "%Y-%m-%d---%H:%M:%S") == "2000-01-01---00:00:00"
    end

  end

  describe "as/2 when providing a string `2000.01.01`" do

    setup do
      {:ok, %{date: "2000.01.01"}}
    end

    test "should be able to convert it to an :date_tuple", %{date: date} do
      assert Timely.as(date, :date_tuple) == {2000, 1, 1}
    end

    test "should be able to convert it to an :datetime_tuple", %{date: date} do
      assert Timely.as(date, :datetime_tuple) == {{2000, 1, 1}, {0, 0, 0}}
    end

    test "should be able to convert it to an :date", %{date: date} do
      assert Timely.as(date, :date) == Date.from_erl!({2000, 1, 1})
    end

    #test "should be able to convert it to an :datetime", %{date: date} do
      #{:ok, datetime, 0} = DateTime.from_iso8601("2000-01-01T00:00:00Z")
      #assert Timely.as(date, :datetime) == datetime
    #end

    test "should be able to convert it to an :ecto_date", %{date: date} do
      assert Timely.as(date, :ecto_date) == Ecto.Date.from_erl({2000, 1, 1})
    end

    test "should be able to convert it to an :ecto_datetime", %{date: date} do
      assert Timely.as(date, :ecto_datetime) == Ecto.DateTime.from_erl({{2000, 1, 1}, {0, 0, 0}})
    end

    test "should be able to convert it to an :iso8601", %{date: date} do
      assert Timely.as(date, :iso8601) == "2000-01-01T00:00:00.000000+00:00"
    end

    test "should be able to convert it to an :iso8601_date", %{date: date} do
      assert Timely.as(date, :iso8601_date) == "2000-01-01"
    end

    test "should be able to convert it to an :iso8601_z", %{date: date} do
      assert Timely.as(date, :iso8601_z) == "2000-01-01T00:00:00Z"
    end

    test "should be able to convert it to an :naive_datetime", %{date: date} do
      assert Timely.as(date, :naive_datetime) == ~N[2000-01-01 00:00:00.000000]
    end

    test "should be able to convert it to an :rfc1123", %{date: date} do
      assert Timely.as(date, :rfc1123) == "Sat, 01 Jan 2000 00:00:00 +0000"
    end

    test "should be able to convert it to an :strftime", %{date: date} do
      assert Timely.as(date, "%Y-%m-%d---%H:%M:%S") == "2000-01-01---00:00:00"
    end

  end

end
