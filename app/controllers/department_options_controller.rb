class DepartmentOptionsController < ApplicationController
  before_action :only_allow_admins

  def index
    error, @options = Register.options
    flash[:notice] = view_context.format_service_error_message( error ) if error.present?
    error, @all_degrees = Register.degrees
    flash[:notice] = view_context.format_service_error_message( error ) if error.present?
  end

  def create
    success = nil
    message = nil
    if params[:new_department]
      success, message = DepartmentOption.create_department(params[:new_department]['name'])
    end

    if params[:new_degree]
      success, message = DepartmentOption.create_degree(params[:new_degree]['name'])
    end
    if success
      flash[:notice] = view_context.format_success_message message
    else
      flash[:notice] = view_context.format_service_error_message( message )
    end
    redirect_to action: :index
  end
  def update

    success, message = DepartmentOption.update_mapping(department_params[:department], department_params[:degrees])

    if success
      flash[:notice] = view_context.format_success_message message
    else
      flash[:notice] = view_context.format_service_error_message( message )
    end
    redirect_to action: :index

  end

  private
  def department_params
    params.require(:department_options).permit( :department, {degrees: []} )
  end

  def only_allow_admins
    if !view_context.user_is_admin?
      flash[:notice] = view_context.format_error_message( "You dont have permission to access this page" )
      redirect_to new_registration_path
    end
  end

end
