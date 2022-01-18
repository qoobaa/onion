class Current < ActiveSupport::CurrentAttributes
  attribute :user

  def user?
    user.present?
  end
end
