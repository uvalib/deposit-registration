class Register
	def self.validate(computing_id_list)
		ids = Register.parse_computing_ids(computing_id_list)
		invalid_ids = []
		ids.each { |computing_id|
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
			response = HTTParty.get("#{DEPOSITREG_URL}/options")
			if response.code == 200
				return response['options']
			else
				# If the server is available, but there is an error in getting the options.
				return {'department' => [ 'Deposit Registration Server Error' ], 'degree' => []}
			end
		rescue
			# If the server isn't available at all, it throws an exception.
			return {'department' => [ 'Deposit Registration Server Not Available' ], 'degree' => []}
		end
	end

	def self.register(requester, department, degree, computing_id_list)
		url = "#{DEPOSITREG_URL}/?auth=#{API_TOKEN}"
		ids = Register.parse_computing_ids(computing_id_list)
		ids = ids.join(",")
		data = { requester: requester, for: ids, department: department, degree: degree }
		response = HTTParty.post(url, body: JSON.dump(data), headers: { 'Content-Type' => 'application/json' })
		return nil if response.code == 200
		return response.message
	end

	def self.parse_computing_ids(computing_id_list)
		# Takes a string and turns it into an array of computing ids.
		return computing_id_list.split(/\W+/) if computing_id_list.present?
		return []
	end
end