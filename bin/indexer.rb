require 'sinatra'
require 'yaml'
require 'slim'
require 'pp'
require "sinatra/reloader" if development?

ROOT_DIR = '../'

module Sinatra
  module Templates
    def slim(template, options={:pretty => true}, locals={})
      render :slim, template, options, locals
    end
  end
end

get '/search/:word' do
  @word = params[:word]
end

get '/misawa/:id' do
  offset = params[:id].to_i
  @data = `ls #{ROOT_DIR}data`.split(" ")
    .sort{|a,b| a.to_i<=>b.to_i}
    .map{|filename| YAML.load_file("#{ROOT_DIR}data/#{filename}")}
    .slice(offset, 10)
    .map{|data|
    begin
      data["text"] = File.open("#{ROOT_DIR}body/#{data["id"].to_i}.txt").read
    rescue => e
      pp e
    end
    data
  }
  slim :index
end

get '/static/:type/:filename' do
  puts File.open("views/static/#{params[:type]}/#{params[:filename]}").read
  send_file "views/static/#{params[:type]}/#{params[:filename]}"
end
