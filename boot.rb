%w{rubygems Git RedCloth yaml}.each {|gem| require gem}
QREPOSITORY_PATH = "/User/andrew/Projects/quirky/system"
if !File.exists? QREPOSITORY_PATH
  Dir.mkdir QREPOSITORY_PATH
end

Dir["models/**/*.rb"].each {|file| load file}
