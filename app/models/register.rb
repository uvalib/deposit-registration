class Register
	def self.validate(computing_id_list)
		invalid_ids = []
		computing_id_list.each { |computing_id|
			url = "#{USERINFO_URL}/user/#{computing_id}?auth=#{API_TOKEN}"
			response = HTTParty.get(url)
			if response.code == 404
				invalid_ids.push(computing_id)
			end
#			puts response.body, response.code, response.message, response.headers.inspect
		}
		return invalid_ids
	end

	def self.options()
		begin
			response = HTTParty.get(OPTIONS_URL)
			if response.code == 200
				return response['options']
			else
				return {'department' => [], 'degree' => []}
			end
		rescue
			return {'department' => [], 'degree' => []}
		end
	end
end