module AuthtokenBehavior

  extend ActiveSupport::Concern

  included do

    # create a time limited JWT for service authentication
    def self.authtoken( secret )

      # expire in 5 minutes
      exp = Time.now.to_i + 5 * 60

      # just a standard claim
      exp_payload = { exp: exp }

      return JWT.encode exp_payload, secret, 'HS256'

    end

  end

end
