namespace :delivery_options do
  task fetch_and_report_saturday_delivery_zipcodes: :environment do
    # scrape UPS website or fetch from UPS API and store in 'response'
    zipcode_delivery_details = UPSClient.saturday_delivery_zipcodes
    return unless zipcode_delivery_details.present?
    saturday_enabled_zipcodes = []
    saturday_disabled_zipcodes = []

    zipcode_delivery_details.each do |code, details|
      zipcode = Zipcode.list_all.find_by(code: code)
      if details[:saturday_enabled] && !zipcode.saturday_enabled
        # enabled zipcode for saturday
        zipcode.enable_saturday_delivery
        saturday_enabled_zipcodes << zipcode
      end
      if !details[:saturday_enabled] && zipcode.saturday_enabled
        # disable zipcode for saturday
        zipcode.disable_saturday_delivery
        saturday_disabled_zipcodes << zipcode
      end
    end
    DeliveryReportMailer.saturday_delivery_report(saturday_enabled_zipcodes, saturday_disabled_zipcodes)
  end
end