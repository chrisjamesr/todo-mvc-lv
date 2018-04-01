class SharedList < ActiveRecord::Base
  belongs_to :user
  belongs_to :list


  PERMISSION = {
    :destroy => 0, 
    :edit =>10,
    :view => 100
  }


  def self.permissable(*args)
    args.each do |action|
      define_method "#{action}able?" do
        self.permission <= PERMISSION[action]
      end
    end
  end

    permissable :view, :edit, :destroy


  # def viewable?
  #   self.permission <= PERMISSION[:view]    
  # end   

  # def editable?
  #   self.permission <= PERMISSION[:collaborator]    
  # end

  # def destroyable?
  #   self.permission <= PERMISSION[:owner]    
  # end  

end
