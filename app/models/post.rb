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

  has_many(
    :comments,
    class_name: "Comment",
    foreign_key: :post_id,
    primary_key: :id
  )

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )

  def top_level_comments
    self.comments.where(parent_comment_id: nil)
  end

end
