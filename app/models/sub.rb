class Sub < ActiveRecord::Base
  validates :title, :description, :moderator_id, presence: true

  belongs_to(
    :moderator,
    :class_name => "User",
    :foreign_key => :moderator_id,
    :primary_key => :id
  )

  has_many(
    :posts,
    through: :posts_subs,
    source: :post
  )

  has_many(
    :posts_subs,
    class_name: "PostsSub",
    foreign_key: :sub_id,
    primary_key: :id
  )



end
