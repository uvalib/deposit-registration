class DepositStatus

   # Adds status check behavior
   include StatusBehavior

   # include auto token support
   include AuthtokenBehavior

   def self.status_by_cid( computing_id )
     url = "#{DEPOSITAUTH_URL}/?auth=#{self.authtoken( AUTH_SHARED_SECRET )}&cid=#{computing_id}"
     return( self.get_status( url ) )
   end

   def self.status_by_created( created )
     url = "#{DEPOSITAUTH_URL}/?auth=#{self.authtoken( AUTH_SHARED_SECRET )}&created=#{created}"
     return( self.get_status( url ) )
   end

   def self.status_by_exported( exported )
     url = "#{DEPOSITAUTH_URL}/?auth=#{self.authtoken( AUTH_SHARED_SECRET )}&exported=#{exported}"
     return( self.get_status( url ) )
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

  def self.get_status( url )

      #puts "==> #{url}"
      begin
         response = HTTParty.get( url )
         return response.code, response['details'] if self.status_ok?( response.code )
         return response.code, response.message
      rescue => e
         return 500, e.message
      end
   end

end