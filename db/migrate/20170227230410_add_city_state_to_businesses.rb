class AddCityStateToBusinesses < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :city, :string
    add_column :businesses, :state, :string
  end
end
