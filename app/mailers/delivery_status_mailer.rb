class DeliveryStatusMailer < ActionMailer::Base
  default from: 'no-reply@ship.com'

  def saturday_enable_notification(packages_affected)
  end

  def saturday_disable_notification(packages_affected)
  end
end
