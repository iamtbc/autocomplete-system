class CreateAutocompletes < ActiveRecord::Migration[7.1]
  def change
    create_table :autocompletes, id: false do |t|
      t.string :query, primary_key: true
      t.jsonb :candidates

      t.timestamps
    end
  end
end
