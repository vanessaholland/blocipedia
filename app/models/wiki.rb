class Wiki < ApplicationRecord
  belongs_to :user
  has_many :collaborators
  has_many :collaborations, through: :collaborators, source: :user

  validates :title, length: { minimum: 1 }, presence: true
  validates :body, length: { minimum: 1 }, presence: true

  def public?
    private == false
  end
end
