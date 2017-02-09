class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis
  has_many :charges
  has_many :collaborators
  has_many :collaborations, through: :collaborators, source: :wiki

  after_initialize :standardizer

  def standard?
    role == 'standard'
  end

  def premium?
    role == 'premium'
  end

  def admin?
    role == 'admin'
  end

  def collaborations
      wikis = []
      Collaborator.where(user: self).each do |collaboration|
        wikis << Wiki.find(collaboration.wiki_id)
      end
      wikis
    end
    
  private

  def standardizer
    self.role ||= 'standard'
  end
end
