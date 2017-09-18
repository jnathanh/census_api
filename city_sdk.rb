class CitySDK
  # wrapper for CitySDK api
  # https://uscensusbureau.github.io/citysdk/developers/gettingstarted/


  def endpoint
    "http://citysdk.commerce.gov"
  end

  def api_key
    :e9f947182b952335b7a7ac66cd9987f86d57a39d
  end

  def headers
    {
      'content-type' => 'application/json',
      'authorization' => Base64.encode64("#{api_key}:").strip
    }
  end

  def add_headers(request)
    request["content-type"] = 'application/json'
    request["authorization"] = "Basic #{Base64.encode64(api_key.to_s + ':').strip}"
  end

  def post(query)
    url = URI(endpoint)
    http = Net::HTTP.new(url.host, url.port)
    request = Net::HTTP::Post.new(url)
    add_headers(request)
    request.body = query
    response = http.request(request)
  end

  def get()

  end

  def query(query_object)
    json = query_object.is_a?(String) ? query_object : query_object.to_json
    response = post(json)
    hash = JSON.parse(response.body)
  end

  def test
    request_obj = {
      level: "state",
      state: "WA",
      variables: [
          "median_home_value"
      ],
      api: "acs5",
      year: "2014"
    }

    response = query request_obj
binding.pry
  end

end