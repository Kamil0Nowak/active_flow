class CreateLessons < ActiveRecord::Migration[8.1]
  def change
    create_table :lessons do |t|
      t.string :title, null: false
      t.text :description
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
