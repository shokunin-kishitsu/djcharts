class Chart
  include Mongoid::Document

  belongs_to :dj
  has_many :tracks

  field :date, type: Date
  field :location, type: String
end