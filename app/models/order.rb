class Order < ApplicationRecord
  belongs_to :user

  validates :date, presence: true
  validates :total, presence: true, numericality: { greater_than: 0, less_than: 999999.99 }
end
