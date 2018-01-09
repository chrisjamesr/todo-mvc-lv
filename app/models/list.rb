class List < ActiveRecord::Base
  # http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#method-i-has_many
  # validates :name, :length => {:minumum => 3}

  has_many :items # just adds methods to my model.
  has_many :shared_lists
  has_many :users, :through => :shared_lists
  validates :name, :presence => true


  def viewable_by?(user)
    shared_list = self.shared_lists.find_by(:user_id => user.id)
    if !shared_list
      return false
    else 
      shared_list.viewable?
    end
  end

end
