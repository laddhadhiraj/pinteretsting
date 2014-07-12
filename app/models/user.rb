class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pins, dependent: :destroy
  has_many :orders, dependent: :destroy

  has_many :authentications, :dependent => :delete_all

  validates :name, presence: true


  def apply_omniauth(auth)
  # In previous omniauth, 'user_info' was used in place of 'raw_info'
  self.email = auth['info']['email']
  self.name = auth['info']['name']
		  # Again, saving token is optional. If you haven't created the column in authentications table, this will fail
		  authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
		end

  
end
