class Register

	def self.validate_department( department )
	   department.nil? == false && department.blank? == false
	end

	def self.validate_degree( degree )
		degree.nil? == false && degree.blank? == false
	end

	def self.validate_user_list( user_id_list )

		return false if user_id_list.nil? || user_id_list.empty?
		begin
			ids = Register.parse_user_ids( user_id_list )
			invalid_ids = []
			ids.each { |computing_id|
				url = "#{USERINFO_URL}/user/#{computing_id}?auth=#{API_TOKEN}"
				response = HTTParty.get(url)

				if response.code == 404
					invalid_ids.push(computing_id)
				end
			}

			return invalid_ids.empty?, invalid_ids
	  rescue => e
		   puts e
			 return false, ids
		end

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
		rescue => e
			puts e
			# If the server isn't available at all, it throws an exception.
			return {'department' => [ 'Deposit Registration Server Not Available' ], 'degree' => []}
		end
	end

	def self.register(requester, department, degree, computing_id_list)

		begin
			url = "#{DEPOSITREG_URL}/?auth=#{API_TOKEN}"
			ids = Register.parse_user_ids(computing_id_list)
			ids = ids.join(",")
			data = { requester: requester, for: ids, department: department, degree: degree }
			response = HTTParty.post(url, body: JSON.dump(data), headers: { 'Content-Type' => 'application/json' })
			return true, nil if response.code == 200
			return false, response.message
		rescue => e
			puts e
			return false, e.message
		end

	end

	def self.parse_user_ids( user_id_list )
		# Takes a string and turns it into an array of computing ids.
		return user_id_list.split(/\W+/) if user_id_list.present?
		return []
	end

	def self.check_depositreg_endpoint
		begin
			response = HTTParty.get("#{DEPOSITREG_URL}/healthcheck")
			if response.code == 200
				return true, ''
			else
				return false, "Endpoint returns #{response.code}"
			end
		rescue => ex
			return false, "Endpoint returns #{ex}"
		end
	end

	def self.check_userinfo_endpoint
		begin
			response = HTTParty.get("#{USERINFO_URL}/healthcheck")
			if response.code == 200
				return true, ''
			else
				return false, "Endpoint returns #{response.code}"
			end
		rescue => ex
			return false, "Endpoint returns #{ex}"
		end
	end

end