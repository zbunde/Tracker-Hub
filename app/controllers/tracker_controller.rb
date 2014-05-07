class TrackerController <  ApplicationController
  def projects

    conn = Faraday.new(:url => 'https://www.pivotaltracker.com') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    response = conn.get do |req|
      req.url '/services/v5/projects/'
      req.headers['X-TrackerToken'] = ENV['TRACKER_TOKEN']
    end

    json_data = JSON.parse(response.body)
    @tracker_data = json_data

  end

  def stories

    conn = Faraday.new(:url => 'https://www.pivotaltracker.com') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
    response = conn.get do |req|

      req.url "/services/v5/projects/#{params["id"]}/stories"
      req.headers['X-TrackerToken'] = ENV['TRACKER_TOKEN']
    end

    json_data = JSON.parse(response.body)

    @tracker = Tracker.new(json_data)


  end

end