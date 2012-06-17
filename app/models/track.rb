class Track
  include Mongoid::Document

  belongs_to :chart

  field :name, type: String
end