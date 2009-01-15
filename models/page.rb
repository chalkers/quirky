class Page
   attr_accessor :name, :title, :description, :keywords, :content

   def self.save(params)
     p = Page.new
     params.each do |param,value|
       p.send("#{param.to_s}=",value) if p.methods.include? "#{param.to_s}="
     end
     p.save
     p
   end
   
   def save
     new_file = !File.exists?("#{QREPOSITORY_PATH}/#{@name}.yaml")
     File.open("#{QREPOSITORY_PATH}/#{@name}.yaml", "w") { |file| YAML.dump(self, file) }
     g = Git.init QREPOSITORY_PATH
     g.add("#{QREPOSITORY_PATH}/#{@name}.yaml")
     begin
       if new_file
         g.commit("#{@name} Created")
       else
         g.commit("#{@name} Updated")
       end
     rescue Git::GitExecuteError
         #TODO       
     end
   end
   
   def self.find(name)
     raise QuirkyException if !File.exists?("#{QREPOSITORY_PATH}/#{name}.yaml")
     YAML.load(File.open("#{QREPOSITORY_PATH}/#{name}.yaml"))
   end
   
   def self.destroy(name)
     if File.exists?("#{QREPOSITORY_PATH}/#{name}.yaml")
        g = Git.init QREPOSITORY_PATH
        g.remove("#{QREPOSITORY_PATH}/#{name}.yaml");
        g.commit("#{name} Deleted")
     end
   end
end