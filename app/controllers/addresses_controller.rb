class AddressesController < ApplicationController
  require 'forecast_io'
  def index
    @address = Address.order("created_at").last
    ForecastIO.api_key = ENV["forecast_api_key"]
    response = ForecastIO.forecast(@address.latitude,@address.longitude)
    currently = response.currently
    @summary = currently.summary
    @temp = currently.temperature
    @saying = ""
    if @temp <= 32
      @saying = "It's freezing out there!"
    elsif @temp >= 33 && @temp <= 60
      @saying = "Still might be pretty chilly out there, now!!"
    elsif @temp >= 61 && @temp <= 85
      @saying = "It's dang nice out."
    else
      @saying = "Oh, man. It's hot as balls!"
    end
  end

  def show
  end

  def new
  end

  def create
    @address = Address.new(params.require(:address).permit(:address))
    @address.save
    redirect_to action: "index"
  end
end
