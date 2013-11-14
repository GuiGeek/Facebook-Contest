class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :city
      t.string :telephone
      t.boolean :newsletter

      t.timestamps
    end
  end
end
