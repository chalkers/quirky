%w{boot sinatra}.each {|lib| require lib}

#TODO Update and create actions. Security/authentication.

get "/" do
  redirect "/index.html"
end

get "/:url.html" do
  begin
    @page = Page.find(params[:url] + ".html") 
  rescue QuirkyException
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
  p = Page.create(params[:page])
  redirect "/#{p.url}"
end

get "/update/:url.html" do
  begin
    @page = Page.find(params[:url] + ".html")
  rescue QuirkyException
    throw :halt, [404, "File not found"]
  end

  haml :update
end

put "/:url.html" do
  p = Page.update(params[:url],params[:page])
  redirect "/#{p.url}"
end

delete "/:url.html" do
  Page.destroy(params[:url] + ".html")
  redirect "/"
end