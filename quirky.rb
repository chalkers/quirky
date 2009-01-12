%w{rubygems sinatra git grit}.each {|gem| require gem}
Dir["models/**/*.rb"].each {|file| load file}

get "/" do
  redirect "/index.html"
end

get "/index.html" do
  @page = Page.find("index.html")
end