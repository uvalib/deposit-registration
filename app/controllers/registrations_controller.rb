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
    invalid_ids = Register.validate(parameters[:user_list].split(/\W+/))
#    @registration = Registration.new(registration_params)

    respond_to do |format|
      if invalid_ids.length == 0
        format.html { redirect_to :back, notice: view_context.format_success_message() }
      else
        format.html { redirect_to :back, { notice: view_context.format_bad_computing_ids(invalid_ids) } }
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
