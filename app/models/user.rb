class User < ApplicationRecord

  validates :user_name, uniqueness: true
  validates_presence_of :user_name

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable



  def conversations
    Conversation.where("sender_id = :user_id OR recipient_id = :user_id", :user_id => self.id).includes(:recipient, :messages).order("messages.created_at DESC")
  end

  def is_admin?
    admin?
  end

end
