class Movie < ActiveRecord::Base
  has_attached_file :photo
  has_attached_file :video
  validates_attachment_content_type :photo, :video,  :url =>':s3_domain_url',
                                    :path => '/:class/:attachment/:id_partition/:style/:filename',
                                    :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  validates_attachment_content_typec :video,  :url =>':s3_domain_url',
                                     :path => '/:class/:attachment/:id_partition/:style/:filename',
                                     :content_type => ["video/mp4"]
  has_many :orders
  has_many :users, through: :orders
  has_many :reviews


end
