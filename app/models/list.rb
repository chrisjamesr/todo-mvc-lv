class List < ActiveRecord::Base
  has_many :items
  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
