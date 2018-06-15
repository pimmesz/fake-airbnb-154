class RemoveCityFromFlats < ActiveRecord::Migration[5.2]
  def change
    remove_column :flats, :city, :string
  end
end
