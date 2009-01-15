%w{rubygems git RedCloth yaml}.each {|gem| require gem}
QREPOSITORY_PATH = FileUtils.pwd + "/system" 
FileUtils.mkdir_p QREPOSITORY_PATH unless File.exists? QREPOSITORY_PATH
Dir["lib/**/*.rb","models/**/*.rb"].each {|file| load file}
