%w{rubygems git RedCloth yaml}.each {|gem| require gem}
QREPOSITORY_PATH = "/Volumes/Work/Sandbox/quirky/system"
Dir.mkdir QREPOSITORY_PATH unless File.exists? QREPOSITORY_PATH
Dir["lib/**/*.rb","models/**/*.rb"].each {|file| load file}
