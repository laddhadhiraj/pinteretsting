class Pin < ActiveRecord::Base
     belongs_to :user
     has_attached_file :image, :styles  => { :large=> "600X600>", :medium => "400x400>", :thumb => "100x100>" }, :processors => [:cropper]


     validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
     
     attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
 		 after_update :reprocess_image, :if => :cropping?

     validates :image, presence: true
     validates :description, presence: true
     
  def cropping?
     !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def image_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(image.path(style))
  end
  
  private
  
  def reprocess_image
    # image.reprocess!
     image.assign(image)
     image.save
  end
end
