class User < ActiveRecord::Base
    def self.import(file)
        CSV.foreach(file.path, headers: true) do |row|
            user = User.new
            user.attributes = row.to_hash.slice(*updatable_attributes)
            user.save!
        end
    end
    
    def self.updatable_attributes
        ["name","email"]
    end
end