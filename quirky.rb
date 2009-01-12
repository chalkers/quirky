%w{rubygems sinatra Git RedCloth}.each {|gem| require gem}
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

get "/new" do
end

post "/" do
end

put "/:url.html" do
end

delete "/:url.html" do
end