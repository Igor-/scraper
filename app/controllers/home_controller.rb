class HomeController < ApplicationController
    def index
    end

    def create

      browser = Watir::Browser.new 
      browser.goto "https://selfsolve.apple.com/agreementWarrantyDynamic.do"
      browser.text_field(name: 'sn').set(params[:warranty][:imei])
      browser.button(id: "warrantycheckbutton").click
      html =  browser.html
      browser.close

      doc = Nokogiri::HTML(html)
      parse_result =  doc.at_css("#hardware-text").inner_html.match(/(:)(.*?)(<br>)/)
      if parse_result.present?
        expiration_date =  parse_result[2].strip
        status = "In warranty"
      else
        expiration_date = ""
        error_message = doc.at_css("#error").inner_html.strip
        if error_message.present?
          status = error_message 
        else
          status = "Out of warranty"
        end
      end
            
      render json: {status: status, expiration_date: expiration_date}
    end
end