require 'sinatra'
require 'dotenv'
require 'pry'
require 'curb'
require 'json/ext'

Dotenv.load
get '/' do
  channel_for_response=params['channel_name']
  face_server = ENV['face_server']
  face = Curl.get("#{face_server}:3000").body
  face = CGI.unescape(face)
  response = {text: "#{face}", username: "smileybot", icon_emoji: ":ghost:", channel: "##{channel_for_response}"}
  Curl.
     post(ENV['incoming_webhook'], response.to_json)
end

