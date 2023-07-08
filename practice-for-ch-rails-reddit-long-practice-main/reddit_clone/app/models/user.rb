# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string
#  session_token   :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    validates :username, :session_token, uniqueness: true
    validates :password_digest, :username, presence: true
    validates :password, length: {minimum: 6, allow_nil: true}
    attr_accessor :password
    before_validation :ensure_session_token 

    has_many :subs, 
        foreign_key: :moderator_id,
        class_name: :Sub,
        inverse_of: :moderator,
        dependent: :destroy

    has_many :posts, 
        foreign_key: :author_id,
        class_name: :Post


    has_many :posts_sub, 
        through: :posts, 
        source: :sub 

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        user&.is_password?(password) ? user : nil
    end

    def password=(password)
        @password=password
        self.password_digest=BCrypt::Password.create(password)
    end

    def is_password?(password)
        bcobj = BCrypt::Password.new(self.password_digest)
        bcobj.is_password?(password)
    end

    def reset_session_token!
        self.session_token=generate_unique_session_token
        self.save!
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= generate_unique_session_token
    end

    private

    def generate_unique_session_token
        token = SecureRandom::urlsafe_base64
        while User.exists?(session_token: token)
            token = SecureRandom::urlsafe_base64
        end
        token
    end
end
