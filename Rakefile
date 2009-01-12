require 'boot'

task :default => :init

desc "Initialise the application"
task :init do
    page = Page.new
    page.url = "index.html"
    page.title = "Congratulations!"
    page.content = "h1. You've done it.\n\nYou've installed quirky!"
    page.save
end