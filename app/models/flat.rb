class Flat < ApplicationRecord
  belongs_to :user
  has_many :flats

  include PgSearch
  multisearchable against: [ :name, :price, :address ]

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
