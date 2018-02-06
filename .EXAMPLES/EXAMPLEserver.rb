require "sinatra"
require "pry"
require "csv"

set :bind, "0.0.0.0"
set :views, File.join(File.dirname(__FILE__), "views")

get "/" do
  redirect to("/players")
end

get "/players" do
  @players = []
  CSV.foreach(csv_file, headers: true) do |row|
    @players << row
  end

  erb :index
end

get '/players/new' do
  erb :new
end

post '/players/new' do
  name = params[:name]
  band = params[:band]
  if !name.empty? && !band.empty?  #happy path
    CSV.open(csv_file, 'a') do |csv|
      csv << [name, band]
    end
    redirect '/players'
  else
    @error = 'ERROR Please fill in all fields, ya doink!'
    erb :new
  end
end

# Helper Methods

def csv_file
  if ENV["RACK_ENV"] == "test"
    "data/players_test.csv"
  else
    "data/players.csv"
  end
end

def reset_csv
  CSV.open(csv_file, "w", headers: true) do |csv|
    csv << ["name", "band"]
  end
end
