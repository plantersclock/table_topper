require "rubygems"
require "sequel"
require "sinatra"

DB = Sequel.connect("postgres://postgres:mysecretpassword@172.17.0.2:5432/postgres")

# Tables
DB.create_table? :game_schemas do
  primary_key :id
  varchar :name
  json :game_data
  json :player_data
end

DB.create_table? :plays do
  primary_key :id
  foreign_key :schema_id, :game_schemas
  json :game_data
end

DB.create_table? :players do
  primary_key :id
  foreign_key :play_id, :plays
  json :player_data
end

set :public_folder, File.dirname(__FILE__) + '/web'

get "/" do
  send_file "web/index.html"
end

get "/api/game_schemas" do
  return "blah"
end

get "/api/game_schemas/:name" do
  "Hello #{params['name']}!"
end