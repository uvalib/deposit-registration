module RegistrationsHelper

  def format_bad_department_message( department )
    format_error_message( content_tag(:span, raw("Empty department name; please revise and submit again.") ) )
  end

  def format_bad_degree_message( degree )
    format_error_message( content_tag(:span, raw("Empty degree name; please revise and submit again.") ) )
  end

	def format_bad_computing_ids_message(ids)

    if ids.nil? || ids.blank?
      message = content_tag(:span, raw("Empty user list; please revise and submit again.") )
    else
		   items = []
		   ids.each { |id|
			   items.push(content_tag(:li, id))
		   }
       message = content_tag(:span, raw("The following users are invalid; please revise and submit again:") + content_tag(:ul, raw(items.join("\n"))))
    end

    format_error_message( message )
	end

  def format_service_error_message( message )
    format_error_message( 'Register service returns: ' +  message )
  end

  def format_success_message()
		padding = content_tag(:div, "", { class: "col-sm-2" })
		notice = content_tag(:div, "All registrations submitted successfully.", { class: "notice col-sm-10" })
		return raw(padding + notice)
	end

  def format_error_message( message )
    padding = content_tag(:div, "", { class: "col-sm-2" })
    return raw (padding + content_tag(:div, message, { class: 'error_message col-sm-10'}))
  end


end
