class AddReferenceToPost < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :subreddit, foreign_key: {to_table: :subs}
  end
end
