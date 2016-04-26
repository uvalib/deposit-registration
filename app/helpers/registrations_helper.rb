module RegistrationsHelper
	def format_bad_computing_ids(ids)
		items = []
		ids.each { |id|
			items.push(content_tag(:li, id))
		}
		list = content_tag(:span, raw("The following computing IDs are not found. Please revise the list and submit again:") + content_tag(:ul, raw(items.join("\n"))))
		padding = content_tag(:div, "", { class: "col-sm-2" })
		return raw (padding + content_tag(:div, list, { class: 'error_message col-sm-10'}))
	end

	def format_success_message()
		padding = content_tag(:div, "", { class: "col-sm-2" })
		notice = content_tag(:div, "All registrations completed successfully.", { class: "notice col-sm-10" })
		return raw(padding + notice)
	end
end
