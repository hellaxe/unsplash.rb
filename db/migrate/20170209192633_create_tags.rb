class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.string :aliases, array: true, default: '{}'

      t.timestamps
    end

    add_index :tags, :aliases, using: 'gin'
  end
end
