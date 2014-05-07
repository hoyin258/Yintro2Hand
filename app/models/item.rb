class Item < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :pictures
  has_many :comments
  belongs_to :location


  def picture
    pictures.first
  end

end
