class Tournament < ApplicationRecord
  belongs_to :owner, class_name: "User"

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :start_at, presence: { message: "is blank or invalid" }
  validates :end_at, presence: { message: "is blank or invalid" }
  validates :owner, presence: true

  scope :future, -> { where("start_at >= ?", DateTime.now) }

  def owned_by(user)
    user == owner
  end
end
