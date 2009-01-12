%w{rubygems Git RedCloth yaml}.each {|gem| require gem}
QREPOSITORY_PATH = "/User/andrew/Projects/quirky/system"
Dir.mkdir QREPOSITORY_PATH unless File.exists? QREPOSITORY_PATH
Dir["models/**/*.rb"].each {|file| load file}
