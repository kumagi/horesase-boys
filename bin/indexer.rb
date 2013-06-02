require 'sinatra'
require 'yaml'
require 'json'
require 'slim'
require 'pp'
require "sinatra/json"
require "sinatra/reloader" if development?
require 'jubatus/recommender/client'

ROOT_DIR = '../'

module Sinatra
	module Templates
		def slim(template, options={:pretty => true}, locals={})
			render :slim, template, options, locals
		end
	end
end

PATH = File.dirname(__FILE__)
BODYPATH = PATH + "/../body/"
DATAPATH = PATH + "/../data/"
DATALIST = `ls #{DATAPATH}`.split(" ")

$index = {}
DATALIST.each{|filename|
	filepath = DATAPATH + filename
	new_one = YAML.load_file(filepath)
	begin
		new_one["body"] = File.open(BODYPATH + new_one["id"].to_s + ".txt").read
	rescue => e
		# body data may be nothing
	end
	$index[new_one["id"]] = new_one
}

def get_data ids
	ids.map{|id| $index[id]}
end


def search word, num
	if word.nil?
		slim :not_found
	else
		cli = Jubatus::Recommender::Client::Recommender.new "127.0.0.1", 9199
		datum = Jubatus::Recommender::Datum.new [["text", @word]], []
		result = cli.similar_row_from_datum "A", datum, num
		@data = get_data(result.map{|m| JSON.parse(m[0])[0]})
	end
end

post '/search/' do
	@word = params[:text]
  @num = 20
  search @word, @num
  slim :index
end


get '/recommend/:word' do
	@word = params[:word]
  search @word, 1
  @data[0]["image"]
end

get '/' do
  redirect "/misawa/1/30"
end
get '/misawa/:id' do
	redirect "/misawa/#{params[:id]}/10"
end
get '/misawa/:id/:num' do
  @word = ""
	offset = params[:id].to_i
	num = params[:num].to_i
	num = 10 if num == 0
	@data = get_data (offset...(offset+num))
	slim :index
end

get '/static/:type/:filename' do
	send_file "views/static/#{params[:type]}/#{params[:filename]}"
end
