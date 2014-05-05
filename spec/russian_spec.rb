# -*- encoding: utf-8 -*-

require File.dirname(__FILE__) + '/spec_helper'

describe Ukrainian do
  describe "with locale" do
    it "should define :'uk' LOCALE" do
      Ukrainian::LOCALE.should == :'uk'
    end

    it "should provide 'locale' proxy" do
      Ukrainian.locale.should == Ukrainian::LOCALE
    end
  end

  describe "during i18n initialization" do
    after(:each) do
      I18n.load_path = []
      Ukrainian.init_i18n
    end

    it "should keep existing translations while switching backends" do
      I18n.load_path << File.join(File.dirname(__FILE__), 'fixtures', 'en.yml')
      Ukrainian.init_i18n
      I18n.t(:foo, :locale => :'en').should == "bar"
    end

    it "should keep existing :uk translations while switching backends" do
      I18n.load_path << File.join(File.dirname(__FILE__), 'fixtures', 'uk.yml')
      Ukrainian.init_i18n
      I18n.t(:'date.formats.default', :locale => :'uk').should == "override"
    end

    it "should NOT set default locale to Ukrainian locale" do
      locale = I18n.default_locale
      Ukrainian.init_i18n
      I18n.default_locale.should == locale
    end
  end

  describe "with localize proxy" do
    before(:each) do
      @time = mock(:time)
      @options = { :format => "%d %B %Y" }
    end

    %w(l localize).each do |method|
      it "'#{method}' should call I18n backend localize" do
        I18n.should_receive(:localize).with(@time, @options.merge({ :locale => Ukrainian.locale }))
        Ukrainian.send(method, @time, @options)
      end
    end
  end

  describe "with translate proxy" do
    before(:all) do
      @object = :bar
      @options = { :scope => :foo }
    end

    %w(t translate).each do |method|
      it "'#{method}' should call I18n backend translate" do
        I18n.should_receive(:translate).with(@object, @options.merge({ :locale => Ukrainian.locale }))
        Ukrainian.send(method, @object, @options)
      end
    end
  end

  describe "strftime" do
    before(:each) do
      @time = mock(:time)
    end

    it "should call localize with object and format" do
      format = "%d %B %Y"
      Ukrainian.should_receive(:localize).with(@time, { :format => format })
      Ukrainian.strftime(@time, format)
    end

    it "should call localize with object and default format when format is not specified" do
      Ukrainian.should_receive(:localize).with(@time, { :format => :default })
      Ukrainian.strftime(@time)
    end
  end

  describe "with pluralization" do
    %w(p pluralize).each do |method|
      it "'#{method}' should pluralize with variants given" do
        variants = %w(вещь вещи вещей вещи)

        Ukrainian.send(method, 1, *variants).should == "вещь"
        Ukrainian.send(method, 2, *variants).should == 'вещи'
        Ukrainian.send(method, 3, *variants).should == 'вещи'
        Ukrainian.send(method, 5, *variants).should == 'вещей'
        Ukrainian.send(method, 10, *variants).should == 'вещей'
        Ukrainian.send(method, 21, *variants).should == 'вещь'
        Ukrainian.send(method, 29, *variants).should == 'вещей'
        Ukrainian.send(method, 129, *variants).should == 'вещей'
        Ukrainian.send(method, 131, *variants).should == 'вещь'
        Ukrainian.send(method, 3.14, *variants).should == 'вещи'
      end

      it "should pluralize with %n as number" do
        variants = ['Произошла %n ошибка', 'Произошло %n ошибки', 'Произошло %n ошибок', 'Произошло %n ошибки']

        Ukrainian.send(method, 1, *variants).should == 'Произошла 1 ошибка'
        Ukrainian.send(method, 2, *variants).should == 'Произошло 2 ошибки'
        Ukrainian.send(method, 3, *variants).should == 'Произошло 3 ошибки'
        Ukrainian.send(method, 5, *variants).should == 'Произошло 5 ошибок'
        Ukrainian.send(method, 10, *variants).should == 'Произошло 10 ошибок'
        Ukrainian.send(method, 21, *variants).should == 'Произошла 21 ошибка'
        Ukrainian.send(method, 29, *variants).should == 'Произошло 29 ошибок'
        Ukrainian.send(method, 129, *variants).should == 'Произошло 129 ошибок'
        Ukrainian.send(method, 131, *variants).should == 'Произошла 131 ошибка'
        Ukrainian.send(method, 3.14, *variants).should == 'Произошло 3.14 ошибки'
      end

      it "should raise an exception when first parameter is not a number" do
        lambda { Ukrainian.send(method, nil, "вещь", "вещи", "вещей") }.should raise_error(ArgumentError)
        lambda { Ukrainian.send(method, "вещь", "вещь", "вещи", "вещей") }.should raise_error(ArgumentError)
      end

      it "should raise an exception when there are not enough variants" do
        lambda { Ukrainian.send(method, 1) }.should raise_error(ArgumentError)
        lambda { Ukrainian.send(method, 1, "вещь") }.should raise_error(ArgumentError)
        lambda { Ukrainian.send(method, 1, "вещь", "вещи") }.should raise_error(ArgumentError)
        lambda { Ukrainian.send(method, 1, "вещь", "вещи", "вещей") }.should_not raise_error(ArgumentError)
        lambda { Ukrainian.send(method, 3.14, "вещь", "вещи", "вещей") }.should raise_error(ArgumentError)
        lambda { Ukrainian.send(method, 3.14, "вещь", "вещи", "вещей", "вещи") }.should_not raise_error(ArgumentError)
      end
    end
  end
end
