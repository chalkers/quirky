class Page
  
   attr_accessor :name, :title, :description, :keywords, :content
   REQUIRED_FIELDS = [:name,:title,:description, :content]
   
   def self.save(params)
     required = (params.keys.first.is_a? String) ? REQUIRED_FIELDS.collect {|key| key.to_s} : REQUIRED_FIELDS
     raise QuirkyRequirdFieldsException if (required - params.keys).size > 0
     p = Page.new
     params.each do |param,value|
       p.send("#{param.to_s}=",value) if p.methods.include? "#{param.to_s}="
     end
     p.save
     p
   end
   
   def content_html
     RedCloth.new(@content).to_html
   end
   
   def save
     raise QuirkyRequirdFieldsException if !is_valid?
     new_file = !File.exists?("#{QREPOSITORY_PATH}/#{@name}.yaml")
     File.open("#{QREPOSITORY_PATH}/#{@name}.yaml", "w") { |file| YAML.dump(self, file) }
     g = Git.init QREPOSITORY_PATH
     g.add("#{QREPOSITORY_PATH}/#{@name}.yaml")
     if new_file
       g.commit("#{@name} Created")
       else
         g.commit("#{@name} Updated")
     end
   end
   
   def self.find(name)
     raise QuirkyNotFoundException if !File.exists?("#{QREPOSITORY_PATH}/#{name}.yaml")
     YAML.load(File.open("#{QREPOSITORY_PATH}/#{name}.yaml"))
   end
   
   def self.destroy(name)
     if File.exists?("#{QREPOSITORY_PATH}/#{name}.yaml")
        g = Git.init QREPOSITORY_PATH
        g.remove("#{QREPOSITORY_PATH}/#{name}.yaml");
        g.commit("#{name} Deleted")
     end
   end
   
   def self.list_all
     Dir["#{QREPOSITORY_PATH}/*.yaml"].collect {|file| file.gsub(QREPOSITORY_PATH + "/","").gsub(".yaml",".html")}
   end
   
   def is_valid?
     !(REQUIRED_FIELDS.collect {|sym| !send(sym.to_s).nil? && send(sym.to_s) != ""}).include? false
   end
   
   def to_s
     @name
   end
end