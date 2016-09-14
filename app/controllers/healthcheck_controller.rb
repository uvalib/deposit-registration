class HealthcheckController < ApplicationController

  skip_before_action :require_auth

  # the basic health status object
  class Health
    attr_accessor :healthy
    attr_accessor :message

    def initialize( status, message )
      @healthy = status
      @message = message
    end

  end

  # the response
  class HealthCheckResponse

    attr_accessor :depositauth
    attr_accessor :depositreg
    attr_accessor :userinfo

    def is_healthy?
      depositreg.healthy && userinfo.healthy
    end
  end

  # # GET /healthcheck
  # # GET /healthcheck.json
  def index
    status = get_health_status( )
    response = make_response( status )
    render json: response, :status => response.is_healthy? ? 200 : 500
  end

  private

  def get_health_status
    status = {}

    # check the deposit registration endpoint
    rc, message = DepositStatus.check_depositauth_endpoint
    status[ :depositauth ] = Health.new( rc, message )

    # check the deposit registration endpoint
    rc, message = Register.check_depositreg_endpoint
    status[ :depositreg ] = Health.new( rc, message )

    # check the user information endpoint
    rc, message = Register.check_userinfo_endpoint
    status[ :userinfo ] = Health.new( rc, message )

    return( status )
  end

  def make_response( health_status )
    r = HealthCheckResponse.new
    r.depositauth = health_status[ :depositauth ]
    r.depositreg = health_status[ :depositreg ]
    r.userinfo = health_status[ :userinfo ]

    return( r )
  end

end
