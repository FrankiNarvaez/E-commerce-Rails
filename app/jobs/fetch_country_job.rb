class FetchCountryJob < ApplicationJob
  queue_as :default

  def perform(user_id, ip)
    country = FetchCountryService.new(ip).perform
    city = FetchCityService.new(ip).perform
    user = User.find_by(id: user_id)

    if country && city
      user.update(country: country, city: city)
    end
  end
end
