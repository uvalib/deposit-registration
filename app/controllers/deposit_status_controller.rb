class DepositStatusController < ApplicationController

  def index

    @lookup = params[:lookup]
    @deposits = []
    @title = 'Libra Deposit Status'
    @instructions = false

    status = :ok

    # are we doing a lookup
    if @lookup.blank? == false
      status, details = DepositStatus.get_status( @lookup )
      if DepositStatus.status_ok?( status ) == true
        @deposits = details
      end
    end

    respond_to do |format|
      format.json { render json: @deposits, status: status }
      if DepositStatus.status_ok?( status ) == true
        format.html { render :index }
      else
        format.html { render :index, message: details }
      end

    end
  end

end
