class Task < ApplicationRecord
    belongs_to :user
    has_many :labelings, dependent: :destroy
    has_many :labels, through: :labelings, source: :label
    validates :name, presence: true
    validates :description, presence: true, length: { maximum: 500 }
    scope :expired, -> { order(expiration_date: :desc) }
    scope :priority, -> { order(priority: :asc) }
    scope :search_name, -> (name){where("name LIKE?","%#{name}%" )}
    scope :search_status, -> (status){where("status LIKE?","%#{status}%")}
    enum priority: [:高, :中, :低]
end
