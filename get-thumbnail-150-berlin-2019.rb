#!/usr/bin/env ruby
require 'rubygems'
require 'json'
require 'pp'
require 'time'
require 'date'
require 'parseconfig'
require 'typhoeus'
require 'awesome_print'

flickr_config = ParseConfig.new('flickr.conf').params
api_key = flickr_config['api_key']

if ARGV.length < 1
  puts "usage: #{$0} [setid]"
  exit
end

def getFlickrResponse(url, params, logger)
  url = "https://api.flickr.com/" + url
  try_count = 0
  begin
    result = Typhoeus::Request.get(url,
                                 :params => params )
    x = JSON.parse(result.body)
logger.debug x.ai
   #logger.debug x["photos"].ai
  rescue JSON::ParserError => e
    try_count += 1
    if try_count < 4
      $stderr.printf("JSON::ParserError exception, retry:%d\n",\
                     try_count)
      sleep(10)
      retry
    else
      $stderr.printf("JSON::ParserError exception, retrying FAILED\n")
      x = nil
    end
  end
  return x
end

logger = Logger.new(STDERR)
logger.level = Logger::DEBUG


extras_str = "url_q"

SET_ID = ARGV[0]

search_url = "services/rest/"

first_page = true
photos_per_page = 0
page = 0
photo_number = 0

while true
  url_params = {
    :method => "flickr.photosets.getPhotos",
    :api_key => api_key,
    :format => "json",
    :nojsoncallback => "1",
    :per_page     => "500",
    :photoset_id => SET_ID,
    :extras =>  extras_str,
    :sort => "date-taken-asc",
    :page => page.to_s
  }
  photos_on_this_page = getFlickrResponse(search_url, url_params, logger)
  if first_page
    first_page = false
    logger.debug photos_on_this_page["photoset"]["pages"]
    number_of_pages_to_retrieve = photos_on_this_page["photoset"]["pages"]
  end
  page += 1
  if page > number_of_pages_to_retrieve
    break
  end
  $stderr.printf("STATUS from flickr API:%s retrieved page:%d of:%d\n", photos_on_this_page["stat"],
    photos_on_this_page["photoset"]["page"], photos_on_this_page["total"].to_i)
  photos_on_this_page["photoset"]["photo"].each do|photo|
    photo["id"] = photo["id"].to_i
    id = photo["id"]
    logger.debug "PHOTO id:" + id.to_s
    logger.debug photo.ai
    photo_number += 1
    logger.debug "PHOTO number:" + photo_number.to_s
    puts(photo["url_q"])   
  end
end
