class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.references :user, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
      t.integer :correct_number

      t.timestamps null: false
    end
  end
end
