class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  validates_presence_of :name

  enum permission: { normal: 0, master: 1}

  has_many :messages, foreign_key: 'to'

end
