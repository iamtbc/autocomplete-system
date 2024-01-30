class CreateFrequencies < ActiveRecord::Migration[7.1]
  def change
    create_table :frequencies do |t|
      t.string :query
      t.integer :count
      t.string :version

      t.timestamps
    end

    add_index :frequencies, [ :query, :version ], unique: true
  end
end
