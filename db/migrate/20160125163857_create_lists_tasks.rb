class CreateListsTasks < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :tasks do |t|
      t.belongs_to :list, index:true
      t.string :description
      t.boolean :done
      t.timestamps null: false
    end
  end
end
