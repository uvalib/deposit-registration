class RegistrationsController < ApplicationController

  def new
    @title = 'Libra Deposit Registration'
    @instructions = view_context.link_to 'Instructions for Registrars', 'http://www.library.virginia.edu/libra/libra-optional-deposit', target: '_blank'
    error, @options = Register.options
    flash[:notice] = view_context.format_service_error_message( error ) if error.present?
  end

  def create

    parameters = registration_params
    flash[:user_list] = parameters[:user_list]
    flash[:department] = parameters[:department]
    flash[:degree] = parameters[:degree]

    success = false
    notice = nil

    if Register.validate_department( parameters[:department] ) == false
      notice = view_context.format_bad_department_message( parameters[:department] )
    elsif Register.validate_degree( parameters[:degree] ) == false
      notice = view_context.format_bad_degree_message( parameters[:degree] )
    else
      success, invalid_ids = Register.validate_user_list( parameters[:user_list] )
       if success == false
         notice = view_context.format_bad_computing_ids_message( invalid_ids )
       end
    end

    if success == true
      success, error_message = Register.register( current_user, parameters[:department], parameters[:degree], parameters[:user_list])
      if success
        notice = view_context.format_success_message( )
        flash[:user_list] = nil
        flash[:department] = nil
        flash[:degree] = nil
      else
        notice = view_context.format_service_error_message( error_message )
      end
    end

    respond_to do |format|
      format.html { redirect_to :back, notice: notice }
    end
  end


  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def registration_params
      params.require(:registration).permit(:department, :degree, :user_list)
    end
end
