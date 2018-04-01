class List < ActiveRecord::Base
  # http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#method-i-has_many
  # validates :name, :length => {:minumum => 3}

  has_many :items # just adds methods to my model.
  has_many :shared_lists
  has_many :users, :through => :shared_lists
  validates :name, :presence => true

  # Dynamic Definition

    def self.permissions_for(*args)
      association = args[0]
      methods = args[1..-1]

      methods.each do |method_name|
        define_method "#{method_name}able_by?" do |user|
          assoc = self.send(association).find_by(:user => user)
          if !assoc
            return false
          else 
            assoc.send("#{method_name}able?")
          end
        end
      end
    end

  permissions_for :shared_lists, :edit, :view, :destroy


 

end
