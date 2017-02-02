class CreateCharges < ActiveRecord::Migration[5.0]
  def change
    create_table :charges do |t|
      t.references :user, foreign_key: true
      t.decimal :amount, precision: 6, scale: 2
      t.boolean :successful

      t.timestamps
    end
  end
end
