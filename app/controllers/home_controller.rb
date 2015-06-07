class HomeController < ApplicationController
    def index
      puts params
    end
    def create

      # doc = Nokogiri::HTML(open("https://selfsolve.apple.com/agreementWarrantyDynamic.do"))
      # agent = Mechanize.new
      # page = agent.get("https://selfsolve.apple.com/agreementWarrantyDynamic.do")
      # form = page.form_with(id: "serialnumbercheck")
      # form.fields.each { |f| pp f }
      
      # field = form.field_with!(name: 'sn')
      # field.value = params[:warranty][:imei]
      
      # pp form.button_with(id: 'warrantycheckbutton')
      # page = form.click_button
      # pp page
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
        status = :in_warranty
      else
        expiration_date = ""
        status = :out_of_warranty
      end



            
      render json: {status: status, expiration_date: expiration_date}
    end
end