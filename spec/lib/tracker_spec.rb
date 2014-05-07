require 'spec_helper'
require 'json'
require_relative '../../app/models/tracker'
require 'faraday'
require 'dotenv'

Dotenv.load


describe Tracker do

  it 'should return a list of all your projects' do
    VCR.use_cassette("projects") do

      conn = Faraday.new(:url => 'https://www.pivotaltracker.com') do |faraday|
        faraday.request :url_encoded
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end

      response = conn.get do |req|
        req.url '/services/v5/projects/'
        req.headers['X-TrackerToken'] = ENV['TRACKER_TOKEN']
      end

      json_data = JSON.parse(response.body)
      @tracker_data = Tracker.new(json_data)

      expect(@tracker_data.projects).to include ("Cote and Klabunde")

    end
  end

  it 'should return a list of stories for a project' do
    VCR.use_cassette("stories") do

      conn = Faraday.new(:url => 'https://www.pivotaltracker.com') do |faraday|
        faraday.request :url_encoded
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end

      response = conn.get do |req|
        req.url "/services/v5/projects/1075532/stories"
        req.headers['X-TrackerToken'] = ENV['TRACKER_TOKEN']
      end

      json_data = JSON.parse(response.body)
      @tracker_data = Tracker.new(json_data)
      expect(@tracker_data.story_name).to include ("As a user")

    end
  end
end

