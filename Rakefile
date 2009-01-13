require 'boot'

task :default => :init

desc "Initialise the application"
task :init do
  if(!File.exists?(QREPOSITORY_PATH+"/index.html.yaml"))
    page = Page.new
    page.url = "index.html"
    page.title = "Congratulations!"
    page.content = "h1. You've done it.\n\nYou've installed quirky!"
    page.keywords = "amazing, super, awesome"
    page.description = "Two words: awesome!"
    page.save
  else
    puts "Already initialised" 
  end
end

desc "Loads test suite"
task :test do
    Dir["tests/**/*.rb"].each { |test| load test }
end