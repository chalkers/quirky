%w{rubygems sinatra RedCloth}.each {|gem| require gem}
Dir["models/**/*.rb"].each {|file| load file}

get "/" do
  redirect "/index.html"
end

get "/:url.html" do
  begin
    @page = Page.find(params[:url] + ".html") 
  rescue
    throw :halt, [404, "File not found"]
  end
  
  haml :page
end