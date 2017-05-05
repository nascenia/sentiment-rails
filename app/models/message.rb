class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  scope :between, ->(start_date, end_date) {where("created_at >= :start AND  created_at <= :end", start: start_date, end: end_date)}
end
