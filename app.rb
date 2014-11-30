require 'sinatra'
require 'sinatra/cross_origin'
require 'open-uri'
require 'nokogiri'
require 'json'

get '/' do
  "Use app package name after slash /play/com.nianticproject.ingress"
end

get '/play/:id' do
  cross_origin allow_methods: [:get]
  content_type :json
  
  pkg = params[:id]  
  link = Nokogiri::HTML(open("https://play.google.com/store/apps/details?id="+pkg))
  parsed_video = link.css('.preview-overlay-container')[0]['data-video-url'].split('?')[0]
  parsed_icon = link.css('.cover-image')[0]['src']
  { youtube_link: parsed_video, icon_link: parsed_icon }.to_json
end