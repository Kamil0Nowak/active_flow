class CreateCourses < ActiveRecord::Migration[8.1]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :description
      t.references :teacher, null: false, foreign_key: { to_table: :users }
      t.date :start_date
      t.date :end_date
      t.integer :capacity
      t.integer :status

      t.timestamps
    end
  end
end
