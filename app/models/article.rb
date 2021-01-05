# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  deadline   :datetime
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord
  validates :title, presence: true
  validates :title, length: { minimum: 3, maximum: 30 }
  validates :title, format: { with: /\A(?!\@)/ }

  validates :content, presence: true
  validates :content, length: { minimum: 10 }
  validates :content, uniqueness: true

  validate :validate_title_and_content_length
 
  validates :deadline, presence: true

  belongs_to :user

  def display_created_at
    I18n.l(self.created_at, format: :default)
  end

  private
  def validate_title_and_content_length
    char_count = self.title.length + self.content.length
    unless char_count > 20
      errors.add(:content, '20文字以上で入力してください')
    end
  end
end
