require "net/http"

class FetchCountryService
  attr_reader :ip
  def initialize(ip)
    @ip = ip
  end

  def perform
    uri = URI("http://ip-api.com/json/#{ip}")
    response = JSON.parse(Net::HTTP.get(uri))
    response.dig("countryCode")

  rescue
    nil
  end
end
