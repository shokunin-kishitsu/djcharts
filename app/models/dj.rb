class Dj
  include Mongoid::Document

  has_many :charts

  field :name, type: String
  field :image, type: String
  field :country, type: String
  field :country_image, type: String
end