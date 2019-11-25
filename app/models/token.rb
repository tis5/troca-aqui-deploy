class Token < ApplicationRecord
  belongs_to :pessoa

  validates_uniqueness_of :pessoa
end
