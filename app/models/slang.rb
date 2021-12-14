class Slang < ApplicationRecord
  belongs_to :user

  has_many :votes
  def self.search(pattern)
    if pattern.blank?  # blank? covers both nil and empty string
      all
    else
      where('word LIKE ? AND is_approved = true', "%#{pattern}%")
    end
  end
end
