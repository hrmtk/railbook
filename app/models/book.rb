class Book < ApplicationRecord
  enum status: %w(reservation now_on_sale end_of_print)
  
  scope :costly, -> { where("price > ?", 3000) }
  scope :written_about, -> (theme) { where("name like ?", "%#{theme}%")}

  belongs_to :publisher

  has_many :book_authors
  has_many :authors, through: :book_authors

  validates :name, presence: true
  validates :name, length: { maximum: 15 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validate do |book|
    if book.name.include?("exercise")
      book.errors[:name] << "I don't like exercise."
    end
  end

  before_validation do |book|
    book.name = book.name.gsub(/Cat/) do |matched|
      "lovely #{matched}"
    end
  end

  after_destroy do |book|
    Rails.logger.info "Book is deleted: #{book.attributes.inspect}"
  end

end
