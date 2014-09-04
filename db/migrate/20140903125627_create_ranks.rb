class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
