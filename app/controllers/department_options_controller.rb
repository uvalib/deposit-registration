class DepartmentOptionsController < ApplicationController
  def index
    error, @options = Register.options
    flash[:notice] = view_context.format_service_error_message( error ) if error.present?
    error, @all_degrees = Register.degrees
    flash[:notice] = view_context.format_service_error_message( error ) if error.present?
  end

  def create
    puts params
  end
  def update
  end
end
