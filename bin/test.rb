require 'jubatus/recommender/client'
require 'readline'
require 'json'
require 'yaml'
require 'pp'

NAME = "A"

stty_save = `stty -g`.chomp
trap("INT") { system "stty", stty_save; exit }

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
    # body data may be nothing
  end
  index[new_one["id"]] = new_one
}

while buf = Readline.readline("> ", true)
  next if buf == ''
  cli = Jubatus::Recommender::Client::Recommender.new "127.0.0.1", 9199
  datum = Jubatus::Recommender::Datum.new [["text", buf.chomp]], []
  result = cli.similar_row_from_datum NAME, datum, 5
  result.each{|r|
    recom = JSON.parse(r[0])
    pp index[recom[0]]
  }
end
