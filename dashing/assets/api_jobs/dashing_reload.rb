#!/usr/bin/env ruby

require 'httparty'

url = "http://localhost:#{ENV['PORT']}/dashboards/dashing"

HTTParty.post(url,
	:body => { auth_token: "#{ENV['DASHING_AUTH_TOKEN']}", event: "reload" }.to_json)

