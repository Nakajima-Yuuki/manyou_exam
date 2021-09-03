class User < ApplicationRecord
    has_many :tasks, dependent: :destroy
    validates :full_name,  presence: true, length: { maximum: 30 }
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    before_validation { email.downcase! }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    def check_admin_presence
      throw :abort if self.admin? && User.where(admin: true).count <= 1
    end
      before_destroy :check_admin_presence
    def check_admin_presence_update
      throw :abort if self.id == current_user.id && User.where(admin: true).count == 1
    end
    before_update :check_admin_presence_update
    attr_accessor :current_user
    def edit_user_info
      throw :abort if self.admin == false && self.id != self.current_user.id
    end
end
