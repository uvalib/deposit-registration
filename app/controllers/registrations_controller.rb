class RegistrationsController < ApplicationController
#  before_action :set_registration, only: [:show, :edit, :update, :destroy]

  # # GET /registrations
  # # GET /registrations.json
  # def index
  #   @registrations = Registration.all
  # end
  #
  # # GET /registrations/1
  # # GET /registrations/1.json
  # def show
  # end

  # GET /registrations/new
  def new
    @options = Register.options
  end

  # # GET /registrations/1/edit
  # def edit
  # end

  # POST /registrations
  # POST /registrations.json
  def create
    parameters = registration_params
    flash[:user_list] = parameters[:user_list]
    flash[:department] = parameters[:department]
    flash[:degree] = parameters[:degree]
    invalid_ids = Register.validate(parameters[:user_list])
    success = false
    if invalid_ids.length > 0
      notice = view_context.format_bad_computing_ids(invalid_ids)
    else
      # TODO-PER: After netbadge auth is added, then the computing ID will be whoever is logged in.
      requester_id = "dpg3k"
      error_message = Register.register(requester_id, parameters[:department], parameters[:degree], parameters[:user_list])
      if error_message
        notice = error_message
      else
        notice = view_context.format_success_message()
        success = true
      end
    end

    respond_to do |format|
      if success
        format.html { redirect_to :back, notice: notice }
      else
        format.html { redirect_to :back, { notice: notice } }
      end
    end
  end

  # # PATCH/PUT /registrations/1
  # # PATCH/PUT /registrations/1.json
  # def update
  #   respond_to do |format|
  #     if @registration.update(registration_params)
  #       format.html { redirect_to @registration, notice: 'Registration was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @registration }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @registration.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # DELETE /registrations/1
  # # DELETE /registrations/1.json
  # def destroy
  #   @registration.destroy
  #   respond_to do |format|
  #     format.html { redirect_to registrations_url, notice: 'Registration was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # # Use callbacks to share common setup or constraints between actions.
    # def set_registration
    #   @registration = Registration.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def registration_params
      params.require(:registration).permit(:department, :degree, :user_list)
    end
end
