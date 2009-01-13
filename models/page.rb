class Page
   attr_accessor :url, :title, :description, :keywords, :content
   #TODO finish create
   def self.create(page)
     p = Page.new
     p.url = page[url]
     p.title = page[title]
     p.description = page[description]
     p.keywords = page[keywords]
     p.content = page[content]
     p.save
     puts p.to_yaml
     p
   end
   def save
     new_file = !File.exists?("#{QREPOSITORY_PATH}/#{@url}.yaml")
     File.open("#{QREPOSITORY_PATH}/#{@url}.yaml", "w") { |file| YAML.dump(self, file) }
     g = Git.init QREPOSITORY_PATH
     g.add("#{QREPOSITORY_PATH}/#{@url}.yaml")
     begin
     if new_file
       g.commit("#{@url} Created")
     else
       g.commit("#{@url} Updated")
     end
     rescue Git::GitExecuteError
         #TODO       
     end
   end
   
   def self.find(url)
     YAML.load(File.open("#{QREPOSITORY_PATH}/#{url}.yaml"))
   end
   
   def self.destroy(url)
     g = Git.init QREPOSITORY_PATH
     g.remove("#{QREPOSITORY_PATH}/#{url}.yaml");
     g.commit("#{url} Deleted")
     nil
   end
end