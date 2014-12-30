require 'test_helper'

class CommitTest < ActiveSupport::TestCase
  setup do
    @commit = commits(:rails_commit)
  end

  test "default_scope" do
    other_commit = commits(:ruby_commit)
    other_commit.created_at = Time.zone.now
    other_commit.save!

    @commit.created_at = Time.zone.now - 1.day
    @commit.save!

    assert_equal([other_commit, @commit], Commit.find([other_commit.id, @commit.id]))
  end

  test ".merge_or_skip_ci? for merge commits" do
    @commit.message = Commit::MERGE_COMMIT_MESSAGE
    assert_equal true, Commit.merge_or_skip_ci?(@commit.message)
  end

  test ".merge_or_skip_ci? for ci skip commits" do
    @commit.message = Commit::CI_SKIP_COMMIT_MESSAGE
    assert_equal true, Commit.merge_or_skip_ci?(@commit.message)

    @commit.message = Commit::SKIP_CI_COMMIT_MESSAGE
    assert_equal true, Commit.merge_or_skip_ci?(@commit.message)
  end
end
