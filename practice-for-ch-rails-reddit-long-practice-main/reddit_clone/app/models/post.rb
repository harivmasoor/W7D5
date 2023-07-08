# == Schema Information
#
# Table name: posts
#
#  id           :bigint           not null, primary key
#  title        :string           not null
#  url          :string
#  content      :string
#  author_id    :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  subreddit_id :bigint
#
class Post < ApplicationRecord
    validates :title, presence: true

    belongs_to :sub,
        foreign_key: :subreddit_id,
        class_name: :Sub

    belongs_to :author, 
        foreign_key: :author_id,
        class_name: :User

    has_many :posts, 
        foreign_key: :subreddit_id,
        class_name: :Sub 

    has_many :sub_moderators, 
        through: :sub, 
        source: :moderator

end
