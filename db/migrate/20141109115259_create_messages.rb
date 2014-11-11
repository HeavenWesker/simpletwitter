class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :user_id
      t.integer :to_id

      t.timestamps
      add_index   :message, [:user_id, :to_id, :created_at]
    end
  end
end
