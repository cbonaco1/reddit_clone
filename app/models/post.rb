class Post < ActiveRecord::Base

  validates :title, :author_id, presence: true

  has_many(
    :posts_subs,
    class_name: "PostsSub",
    foreign_key: :post_id,
    primary_key: :id,
    inverse_of: :post
  )

  has_many(
    :subs,
    through: :posts_subs,
    source: :sub
  )

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )

end
