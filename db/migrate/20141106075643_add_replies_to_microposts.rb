class AddRepliesToMicroposts < ActiveRecord::Migration
  def change
    add_column  :microposts, :in_reply_to, :string
    add_index   :microposts, :in_reply_to
    add_column  :users, :id_name, :string
    add_index   :users, :id_name, unique: true
  end
end
