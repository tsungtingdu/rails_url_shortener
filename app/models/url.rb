# frozen_string_literal: true

class Url < ApplicationRecord
  validates_presence_of :long_url
  belongs_to :user

  def get_url_count
    Url.all.size
  end
end
