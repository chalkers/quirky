require 'boot'
require 'sinatra'

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
  @page = Page.new
  @page.url = ".html"
  haml :new
end

post "/" do
  p = Page.create(params)
  redirect "/#{p.url}"
end

get "/update/:url.html" do
end

put "/:url.html" do
  p = Page.update(params[:url],params[:page])
  redirect "/#{p.url}"
end

delete "/:url.html" do
  Page.destroy(params[:url] + ".html")
  redirect "/"
end