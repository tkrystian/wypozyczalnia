class Movie < ActiveRecord::Base
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 6 }
  has_attached_file :photo, :url =>':s3_domain_url',
                    :path => '/:class/:attachment/:id_partition/:style/:filename'

  has_attached_file :video,
                    :url =>':s3_domain_url',
                    :path => '/:class/:attachment/:id_partition/:style/:filename'

  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  validates_attachment_content_type :video,       :content_type => ["video/mp4"]

  has_many :orders
  has_many :users, through: :orders
  has_many :reviews


end
