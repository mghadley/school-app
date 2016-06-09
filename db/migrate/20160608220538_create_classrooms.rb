class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.string :name
      t.string :subject
      t.integer :student_count
      t.belongs_to :school

      t.timestamps null: false
    end
  end
end
