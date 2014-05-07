class Picture < ActiveRecord::Base
  # include Paperclip::Glue

  belongs_to :item


  has_attached_file :file,
                    :url  => "/assets/images/:style/:id.:basename.:extension",
                    :path => ":rails_root/public/assets/images/:style/:id.:basename.:extension",
                    :styles => { :large => "1024x1024>", :thumb => "100x100>" },
                    :default_url => "/images/:style/missing.png"

  validates_attachment :file,
                       :presence => true,
                       :content_type => { :content_type => /\Aimage/ },
                       :size => { :less_than => 2.megabytes  }

end
