class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image, dependent: :destroy

  scope :movies, -> { where(category: 'Movie') }
  scope :serials, -> { where(category: 'Serial') }
  scope :cartoons, -> { where(category: 'Cartoon') }

  def posted_time
    self.created_at.strftime('%c')
  end
end
