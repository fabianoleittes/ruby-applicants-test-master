class Model < ActiveRecord::Base
  belongs_to :make

  validates :name, :make_id, presence: true
end
