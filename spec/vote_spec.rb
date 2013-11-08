require 'spec_helper'

describe Vote do 

  describe "#up_vote?" do
    it "returns true for an upvote" do
      v = Vote.new(value: 1)
      v.up_vote?.should be_true
    end
    it "returns false for a downvote" do
      v= Vote.new(value: -1)
      v.up_vote?.should be_false
  end
end
  
  describe "#down_vote?" do
    it "returns true for a downvote" do
      v = Vote.new(value: -1)
      v.down_vote?.should be(true)
    end
    it "returns false for an upvote" do
      v = Vote.new(value: 1)
      v.down_vote?.should be_false
    end
  end

  describe "#update_post" do
    it "calls `update_rank` on post" do
      post = create(:post)
      post.should respond_to(:update_rank)
      post.should_receive(:update_rank)
      Vote.create(value: 1, post: post)
    end
  end
end