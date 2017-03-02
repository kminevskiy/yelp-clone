class CreateUsersBusinessesServicesReviewCategory < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email
      t.string :password_digest
      t.timestamps
    end

    create_table :businesses do |t|
      t.string :name
      t.string :phone_num
      t.string :address
      t.integer :user_id
      t.timestamps
    end

    create_table :categories do |t|
      t.string :name
      t.timestamps
    end

    create_table :services do |t|
      t.integer :business_id
      t.integer :category_id
      t.timestamps
    end

    create_table :reviews do |t|
      t.text :comment
      t.integer :rating
      t.integer :user_id
      t.integer :business_id
      t.timestamps
    end
  end
end
