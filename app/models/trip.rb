class Trip < ApplicationRecord
  belongs_to :user
  belongs_to :flat

  include PgSearch
  multisearchable against: [ :description ]
end
