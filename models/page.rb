class Page
   attr_accessor :url, :title, :description, :keywords, :content
   def save
     File.open("#{QREPOSITORY_PATH}/#{@url}.yaml", "w") { |file| YAML.dump(self, file) }
     g = Git.init QREPOSITORY_PATH
     g.add("#{QREPOSITORY_PATH}/#{@url}.yaml")
     g.commit("#{@url} Created")
   end
   
   def self.find(url)
     YAML.load(File.open("#{QREPOSITORY_PATH}/#{url}.yaml"))
   end
end