class Message < ApplicationRecord

  before_update :update_tracker
  validates_presence_of :title,:content,:from,:to

  enum status: {unread: 0, read: 1, archived: 2}

  belongs_to :sender, class_name: 'User', foreign_key: 'from'
  belongs_to :receiver, class_name: 'User', foreign_key: 'to'

  delegate :name,:email, to: :sender, prefix: true

  scope :sent_to, -> (user) { where(to: user.id).where.not(status: 2)}
  scope :all_sent_to, -> (user) { where(to: user.id)}
  scope :ordered, -> {order('created_at DESC')}
  attr_accessor :receiver_email

  def update_tracker
    if status_changed?
      if read? && status_was == 'unread'
        self.visualized = Time.now
      elsif archived?
        self.archived = Time.now
      end
    end
  end
end
