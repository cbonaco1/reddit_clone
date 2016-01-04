class PostsSub < ActiveRecord::Base

  validates :post, :sub, presence: true

  belongs_to(
    :post,
    class_name: "Post",
    foreign_key: :post_id,
    primary_key: :id,
    inverse_of: :posts_subs
  )

  belongs_to(
    :sub,
    class_name: "Sub",
    foreign_key: :sub_id,
    primary_key: :id,
    inverse_of: :posts_subs
  )

end
