%w{rubygems sinatra RedCloth}.each {|gem| require gem}
Dir["models/**/*.rb"].each {|file| load file}

get "/" do
  redirect "/index.html"
end

get "/:url.html" do
  @page = Page.find(params[:url] + ".html")
  haml :page
end