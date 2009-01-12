require 'git'

Dir["models/**/*.rb"].each {|file| load file}

task :default => :bootstrap

desc "Bootstrap the application"
task :bootstrap do
    puts "Bootstrapping Application.."
    puts "Creating 'system' directory.."

    if !File.exists?("system")
        Dir.mkdir("system")
        puts "Created folder 'system'"
    else
        puts "Directory 'system' already exists.."
    end
    path = "#{File.dirname(__FILE__)}/system"
    repos = Git.init path
    page = Page.new
    page.url= "index.html"
    page.title= "Congratulations!"
    page.content= "h1. You've done it.\nYou've installed quirky!"
    page.save
    repos.add("#{path}/index.html.yaml")
    repos.commit("Bootstapping application!")
end