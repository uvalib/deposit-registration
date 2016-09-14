class DepositStatus

	def self.get_status( computing_id )

		begin
			url = "#{DEPOSITAUTH_URL}/?auth=#{API_TOKEN}&cid=#{computing_id}"
			response = HTTParty.get( url )
			return response.code, response['details'] if status_ok?( response.code )
			return response.code, response.message
		rescue => e
			return 500, e.message
		end

	end

	def self.check_depositauth_endpoint
		begin
			response = HTTParty.get("#{DEPOSITAUTH_URL}/healthcheck")
			if status_ok?( response.code )
				return true, ''
			else
				return false, "Endpoint returns #{response.code}"
			end
		rescue => ex
			return false, "Endpoint returns #{ex}"
		end
	end

	def self.status_ok?( status )
		return status == 200
	end

end