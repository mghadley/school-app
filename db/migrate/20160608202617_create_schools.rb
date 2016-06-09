class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :state
      t.integer :capacity
      t.integer :student_count

      t.timestamps null: false
    end
  end
end
