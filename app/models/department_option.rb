class DepartmentOption

   # Adds status check behavior
   include StatusBehavior

  def self.create_department name
    create_option 'department', name

  end

  def self.create_degree name
    create_option 'degree', name
  end

  def self.update_mapping department, degrees
    begin
      degrees.reject! &:blank?

      url = "#{DEPOSITREG_URL}/optionmap?auth=#{API_TOKEN}"
      data = { department: department, degrees: degrees }
      response = HTTParty.put(url, body: JSON.dump(data), headers: { 'Content-Type' => 'application/json' })
      puts response
      return true, "Successfully updated #{department}" if self.status_ok?( response.code )
      return false, response.message
    rescue => e
      puts e
      return false, e.message
    end

  end


  private
  # Used to create departments or degrees
  # duplicates are not allowed
  # option is either 'department' or 'degree'
  def self.create_option option, name
    raise "Bad option name" unless ['department', 'degree'].include?(option)
    begin
      url = "#{DEPOSITREG_URL}/options?auth=#{API_TOKEN}"
      data = { option: option, value: name }
      response = HTTParty.post(url, body: JSON.dump(data), headers: { 'Content-Type' => 'application/json' })
      puts response
      return true, "Successfully created #{option}" if self.status_ok?( response.code )
      return false, response.message
    rescue => e
      puts e
      return false, e.message
    end
  end

end
