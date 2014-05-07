require 'spec_helper'
require 'json'
require_relative '../../app/models/tracker'
require 'faraday'
require 'dotenv'

Dotenv.load


describe Tracker do

  it 'should return a list of all your projects' do
    VCR.use_cassette("pivitol") do

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
      @tracker_data = Tracker.new(json_data)

      expect(@tracker_data.projects).to include ("Cote and Klabunde")


    end

    it 'should '

    end
  end
