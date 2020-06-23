class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.boolean :vip, default: 0
      t.boolean :moder, default: 0
      t.boolean :admin, default: 0
      t.boolean :owner, default: 0
      t.integer :user_id

      t.timestamps
    end
  end
end
