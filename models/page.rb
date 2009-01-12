require "yaml"

class Page
   attr_accessor :url, :title, :description, :keywords, :content
   def save
     File.open("system/#{@url}.yaml", "w") { |file| YAML.dump(self, file) }
   end
   
   def self.find(url)
     File.open("system/#{url}.yaml") { |file| YAML.load(file) }
   end
end