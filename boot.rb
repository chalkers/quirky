%w{rubygems git RedCloth yaml}.each {|gem| require gem}
QREPOSITORY_PATH = FileUtils.pwd + "/system" unless QREPOSITORY_PATH
FileUtils.mkdir_p QREPOSITORY_PATH unless File.exists? QREPOSITORY_PATH
Dir["lib/**/*.rb","models/**/*.rb"].each {|file| load file}
