class ImportsController < ApplicationController
  def new
  end

  def create
    RefreshTokensJob.perform_now(Current.user)
    forms = FetchCheckoutFormsJob.perform_now(Current.user)

    ActiveRecord::Base.transaction do
      forms.each do |form|
        order = Current.user.orders.find_or_initialize_by(uid: form['id'])
        order.update!(
          date: form.dig('payment', 'finishedAt'),
          total: form.dig('payment', 'paidAmount', 'amount'),
          description: form.dig('lineItems').map { |line_item| line_item.dig('offer', 'name') }.join(', ')
        )
      end
    end

    redirect_to orders_path
  end
end
