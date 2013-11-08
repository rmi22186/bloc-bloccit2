module PostsHelper
  def comment_count(post)
    pluralize(post.comments.count, 'Comment')
  end
end