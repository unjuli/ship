every :sunday, :at => '07:00am', :roles => [:app] do
  rake 'delivery_options:fetch_and_report_saturday_delivery_zipcodes', :output => {:error => 'log/fetch_and_report_saturday_delivery_zipcodes.err', :standard => 'log/fetch_and_report_saturday_delivery_zipcodes.log'}
end