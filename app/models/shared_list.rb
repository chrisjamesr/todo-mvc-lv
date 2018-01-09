class SharedList < ActiveRecord::Base
  belongs_to :user
  belongs_to :list

  PERMISSIONS = {
    :owner => 0, 
    :collaborator =>10,
    :guest => 100
  }

  def viewable?
    self.permission <= PERMISSION[:guest]    
  end   

  def editable?
    self.permission <= PERMISSION[:collaborator]    
  end

  def destroyable?
    self.permission <= PERMISSION[:owner]    
  end  

end
