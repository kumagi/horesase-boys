# -*- coding: utf-8 -*-
require 'jubatus/recommender/client'
require 'yaml'
require 'pp'
require 'json'

PATH = File.dirname(__FILE__)
BODYPATH = PATH + "/../body/"
DATAPATH = PATH + "/../data/"
DATALIST = `ls #{DATAPATH}`.split(" ")

index = {}
DATALIST.each{|filename|
  filepath = DATAPATH + filename
  new_one = YAML.load_file(filepath)
  begin
    new_one["body"] = File.open(BODYPATH + new_one["id"].to_s + ".txt").read
  rescue => e
    # body data may be missed (not bug
  end
  index[new_one["id"]] = new_one
}

cli = Jubatus::Recommender::Client::Recommender.new "127.0.0.1", 9199
index.each{|id, misawa|
  key = [id, misawa["image"]].to_json
  value = misawa["title"] + misawa["character"] + misawa["body"].to_s
  pp "update: #{value}"
  datum = Jubatus::Recommender::Datum.new([["text", value]],[])
  cli.update_row("A", key, datum)
}
