#encoding:utf-8
module ApplicationHelper
	
	def yes_or_no?(value)
		value ? "Sim" : "Nao"
	end

	def status?(value)
		value ? "Ativo" : "Nao ativo"
	end
	
	def flash_message
        messages = ""
        [:notice, :info, :warning, :error].each {|type|
          if flash[type]
            messages += "<p class=\"#{type}\">#{flash[type]}</p>"
          end
        }
        messages.html_safe
    end

end
