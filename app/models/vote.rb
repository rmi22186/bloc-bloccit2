class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  attr_accessible :value, :post
  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote." } # 'value' can only be 1 or 2 values, so we use the 'inclusion' validation to state a defined set of values that 'value' can be

  after_save :update_post

  def up_vote?
    value == 1
  end

  def down_vote?
    value == -1
  end

  private

  def update_post
    self.post.update_rank
  end

end