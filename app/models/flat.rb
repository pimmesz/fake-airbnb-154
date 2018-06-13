class Flat < ApplicationRecord
  belongs_to :user
  has_many :flats

  include PgSearch
  multisearchable against: [ :name, :price, :city ]
end
