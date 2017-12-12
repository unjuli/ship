class DeliveryReportMailer < ActionMailer::Base
  default to: 'abc@123.com',
          from: 'reports@ship.com'

  def saturday_delivery_report(disabled_zipcodes, enabled_zipcodes)
    @disabled_zipcodes = disabled_zipcodes
    @enabled_zipcodes = enabled_zipcodes
    mail(subject: 'Saturday Delivery Report')
  end

  def special_saturday_delivery_report(enabled_zipcode)
    @enabled_zipcode = enabled_zipcode
    mail(subject: 'Special Saturday Delivery Report')
  end

end
