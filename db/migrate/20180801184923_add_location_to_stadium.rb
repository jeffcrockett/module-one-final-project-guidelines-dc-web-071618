class AddLocationToStadium < ActiveRecord::Migration[5.0]
  def change
    add_column :stadiums, :location, :string
  end
end
