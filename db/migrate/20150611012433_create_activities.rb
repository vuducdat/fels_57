class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :target_id
      t.string :target_type
      t.integer :type
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
