class DepositStatus

	# Adds status check behavior
	include StatusBehavior

	def self.get_status( computing_id )

		begin
			url = "#{DEPOSITAUTH_URL}/?auth=#{API_TOKEN}&cid=#{computing_id}"
			#puts "==> #{url}"
			response = HTTParty.get( url )
			return response.code, response['details'] if self.status_ok?( response.code )
			return response.code, response.message
		rescue => e
			return 500, e.message
		end

	end

	def self.check_depositauth_endpoint
		begin
			url = "#{DEPOSITAUTH_URL}/healthcheck"
			#puts "==> #{url}"
			response = HTTParty.get( url )
			if self.status_ok?( response.code )
				return true, ''
			else
				return false, "Endpoint returns #{response.code}"
			end
		rescue => ex
			return false, "Endpoint returns #{ex}"
		end
	end

end