QREPOSITORY_PATH = FileUtils.pwd + "/system"
%w{boot sinatra}.each {|lib| require lib}

#TODO Validation. Security/authentication. Branching site. Git remote adding and removing.
# =>  Previewing. Better error handling. Sitemap generation. Admin section.

before do
  
end

error QuirkyNotFoundException do
  throw :halt, [404, "File not found"]
end

helpers do
  def partial(partial, options={})
        haml partial, options.merge!(:layout => false)
  end
  
  def redirect_to(page)
    redirect "/#{page.to_s}.html"
  end
end

get "/" do
  redirect_to :index
end

get "/:name.html" do
  @page = Page.find(params[:name]) 
  haml :page
end

get "/new" do
  @page = Page.new
  haml :new
end

post "/" do
  redirect_to Page.save(params)
end

get "/update/:name.html" do
  @page = Page.find(params[:name])
  haml :update
end

put "/:name.html" do
  redirect_to Page.save(params)
end

delete "/:name.html" do
  Page.destroy(params[:name])
  redirect "/"
end