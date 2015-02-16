class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :orders
  has_many :movies, through: :orders
  has_many :reviews
  has_many :watchables
  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  validates :email,
            :presence => { message: "nie może być pusty"},
            :uniqueness => { message: "nie może być już wykorzystany"}
  validates_format_of :email, with: EMAIL_REGEX, message: "ma nieprawidłowy format"




  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable


end
