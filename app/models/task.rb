class Task < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true, length: { maximum: 500 }
end
