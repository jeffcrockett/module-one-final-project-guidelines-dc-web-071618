class AddCapacityToStadium < ActiveRecord::Migration[5.0]
  def change
    add_column :stadiums, :capacity, :string
  end
end
