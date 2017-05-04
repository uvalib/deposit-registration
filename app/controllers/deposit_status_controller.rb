class DepositStatusController < ApplicationController

  def index

    # check inbound params
    @cid_lookup, @created_lookup, @exported_lookup = pick_search_params

    @title = 'Libra Deposit Status'
    @deposits = []

    # do the lookup
    status, details = do_lookup( @cid_lookup, @created_lookup, @exported_lookup )
    @deposits = details if DepositStatus.status_ok?( status )

    respond_to do |format|
      format.json { render json: @deposits, status: status }
      if DepositStatus.status_ok?( status ) == true
        format.html { render :index }
      else
        format.html { render :index, message: details }
      end

    end
  end

  private

  def do_lookup( cid, created, exported )

    # lookup by CID
    return( DepositStatus.status_by_cid( cid ) ) if cid.present?

    # lookup by created
    return( DepositStatus.status_by_created( created ) ) if created.present?

    # lookup by exported
    return( DepositStatus.status_by_exported( exported ) ) if exported.present?

    # nothing to do
    return true, []
  end

  def pick_search_params

    return params[:cid_lookup], nil, nil if params[:cid_lookup].present?
    return nil, params[:created_lookup], nil if params[:created_lookup].present?
    return nil, nil, params[:exported_lookup] if params[:exported_lookup].present?
    return nil, nil, nil
  end
end
