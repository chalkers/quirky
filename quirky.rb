%w{boot sinatra}.each {|lib| require lib}

#TODO Security/authentication. Branching site. Git remote adding and removing.
# =>  Previewing. Better error handling. Sitemap generation. Admin section.

helpers do
  def partial(partial, options={})
        haml partial, options.merge!(:layout => false)
  end
end

get "/" do
  redirect "/index.html"
end

get "/:name.html" do
  begin
    @page = Page.find(params[:name]) 
  rescue QuirkyException
    throw :halt, [404, "File not found"]
  end
  
  haml :page
end

get "/new" do
  @page = Page.new
  haml :new
end

post "/" do
  p = Page.save(params)
  redirect "/#{p.name}.html"
end

get "/update/:name.html" do
  begin
    @page = Page.find(params[:name])
  rescue QuirkyException
    throw :hanlt, [404, "File not found"]
  end

  haml :update
end

put "/:name.html" do
  p = Page.save(params)
  redirect "/#{p.name}.html"
end

delete "/:name.html" do
  Page.destroy(params[:name])
  redirect "/"
end