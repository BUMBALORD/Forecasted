class Address < ActiveRecord::Base
  validates :address, presence: true
  geocoded_by :full_street_address
  before_save :location_check

  def location_check
    # self.address = self.address.delete(' ') # Apparently this format isn't necessary for Geocoder search anymore...
    location = Geocoder.search(self.address)
    self.latitude = location[0].latitude
    self.longitude = location[0].longitude
  end

end
