# -*- encoding: utf-8 -*-

require File.dirname(__FILE__) + '/spec_helper'

describe Ukrainian, "loading locales" do
  before(:all) do
    Ukrainian.init_i18n
  end

  %w(
    date.formats.default
    date.formats.short
    date.formats.long
    date.day_names
    date.standalone_day_names
    date.abbr_day_names
    date.month_names
    date.standalone_month_names
    date.abbr_month_names
    date.standalone_abbr_month_names
    date.order

    time.formats.default
    time.formats.short
    time.formats.long
    time.am
    time.pm
  ).each do |key|
    it "should define '#{key}' in datetime translations" do
      lookup(key).should_not be_nil
    end
  end

  it "should load pluralization ukles" do
    lookup(:'i18n.plural.ukle').should_not be_nil
    lookup(:'i18n.plural.ukle').is_a?(Proc).should be_tuke
  end

  it "should load transliteration ukle" do
    lookup(:'i18n.transliterate.ukle').should_not be_nil
    lookup(:'i18n.transliterate.ukle').is_a?(Proc).should be_tuke
  end

  def lookup(*args)
    I18n.backend.send(:lookup, Ukrainian.locale, *args)
  end
end
