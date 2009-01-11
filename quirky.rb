%w{rubygems sinatra git grit}.each {|gem| require gem}

get "/" do
  redirect "/index.html"
end

get "/index.html" do
  haml "%h1 Hello World"
end