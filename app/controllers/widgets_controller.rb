# app/controllers/widgets_controller.rb
class WidgetsController < ApplicationController
  class TestDocument < Prawn::Document
    def to_pdf
      text "Hello World!"
      render
    end
  end

  def index
    output = TestDocument.new.to_pdf
    respond_to do |format|
      format.pdf { 
        send_data output, :filename => "hello.pdf", :type => "application/pdf", :disposition => "inline"
      }
      format.html {
        render :text => "<h1>Use .pdf</h1>".html_safe
      }
    end
  end
end
