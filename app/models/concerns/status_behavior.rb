module StatusBehavior

  extend ActiveSupport::Concern

  included do

    def self.status_ok?( status )
      return( status == 200 || status == 201 )
    end

  end

end
