class CreateUserRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :user_relationships do |t|
      t.integer :user_id
      t.integer :related_user_id

      t.timestamps
    end
  end
end
