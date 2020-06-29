class Register

  # Adds status check behavior
  include StatusBehavior

  # include auto token support
  include AuthtokenBehavior

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
        url = "#{USERINFO_URL}/user/#{computing_id}?auth=#{self.authtoken( AUTH_SHARED_SECRET )}"
        #puts "==> #{url}"
        response = HTTParty.get(url, { timeout: WEBSERVICE_TIMEOUT })

        if self.status_ok?( response.code ) == false
          invalid_ids.push( computing_id )
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
      url = "#{DEPOSITREG_URL}/optionmap"
      #puts "==> #{url}"
      response = HTTParty.get(url, { timeout: WEBSERVICE_TIMEOUT })

      if self.status_ok?( response.code )
        return nil, response['options'].sort_by! {|opt| opt['department'].downcase }
      else
        # If the server is available, but there is an error in getting the options.
        return "Deposit Registration Server Error: #{response.code}", []
      end
    rescue => e
      puts e
      # If the server isn't available at all, it throws an exception.
      return "Deposit Registration Server Not Available: #{e}", []
    end
  end

  def self.degrees
    begin
      url = "#{DEPOSITREG_URL}/options"
      #puts "==> #{url}"
      response = HTTParty.get(url, { timeout: WEBSERVICE_TIMEOUT })

      if self.status_ok?( response.code )
        return nil, response['options']['degrees']
      else
        # If the server is available, but there is an error in getting the options.
        return "Deposit Registration Server Error: #{response.code}", []
      end
    rescue => e
      puts e
      # If the server isn't available at all, it throws an exception.
      return "Deposit Registration Server Not Available: #{e}", []
    end
  end

  def self.register(requester, department, degree, computing_id_list)

    begin
      url = "#{DEPOSITREG_URL}/?auth=#{self.authtoken( AUTH_SHARED_SECRET )}"
      #puts "==> #{url}"
      ids = Register.parse_user_ids(computing_id_list)
      ids = ids.join(",")
      data = { requester: requester, for: ids, department: department, degree: degree }
      response = HTTParty.post(url, body: JSON.dump(data), headers: { 'Content-Type' => 'application/json' })
      return true, nil if self.status_ok?( response.code )
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
      url = "#{DEPOSITREG_URL}/healthcheck"
      #puts "==> #{url}"
      response = HTTParty.get(url, { timeout: HEALTHCHECK_TIMEOUT } )

      if self.status_ok?( response.code )
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
      url = "#{USERINFO_URL}/healthcheck"
      #puts "==> #{url}"
      response = HTTParty.get(url, { timeout: HEALTHCHECK_TIMEOUT } )

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
