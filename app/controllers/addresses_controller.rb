class AddressesController < ApplicationController
  require 'forecast_io'
  def index
    @address = Address.order("created_at").last
    ForecastIO.api_key = ENV["forecast_api_key"]
    response = ForecastIO.forecast(@address.latitude,@address.longitude)
    currently = response.currently
    @summary = currently.summary
    @temp = currently.temperature
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
