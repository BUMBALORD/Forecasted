class Address < ActiveRecord::Base
  validates :address, presence: true
  geocoded_by :full_street_address
  before_save :location_check

  def location_check
    location = Geocoder.search(self.address)
    self.latitude = location[0].latitude
    self.longitude = location[0].longitude
  end

end
