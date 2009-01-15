class Page
   attr_accessor :url, :title, :description, :keywords, :content

   def self.save(params)
     p = Page.new
     params.each do |param,value|
       p.send("#{param.to_s}=",value) if p.methods.include? "#{param.to_s}="
     end
     p.save
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
     raise QuirkyException if !File.exists?("#{QREPOSITORY_PATH}/#{url}.yaml")
     YAML.load(File.open("#{QREPOSITORY_PATH}/#{url}.yaml"))
   end
   
   def self.destroy(url)
     if File.exists?("#{QREPOSITORY_PATH}/#{url}.yaml")
        g = Git.init QREPOSITORY_PATH
        g.remove("#{QREPOSITORY_PATH}/#{url}.yaml");
        g.commit("#{url} Deleted")
     end
   end
end