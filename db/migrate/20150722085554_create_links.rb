class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :given_url
      t.string :uniq_key

      t.timestamps null: false
    end
  end
end
