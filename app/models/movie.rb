class Movie < ActiveRecord::Base
  has_attached_file :photo
  validates_attachment_content_type :photo, :video,  :url =>':s3_domain_url',
                                    :path => '/:class/:attachment/:id_partition/:style/:filename',
                                    :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  has_many :orders
  has_many :users, through: :orders
  has_many :reviews

  has_attached_file :video,  :url =>':s3_domain_url',
                    :path => '/:class/:attachment/:id_partition/:style/:filename',
                    :content_type => ["video/mp4"]
end
