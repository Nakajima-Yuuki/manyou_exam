class Task < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true, length: { maximum: 500 }
    scope :expired, -> { order(expiration_date: :desc) }
    scope :search_name, -> (name){where("name LIKE?","%#{name}%" )}
    scope :search_status, -> (status){where("status LIKE?","%#{status}%")}
end
