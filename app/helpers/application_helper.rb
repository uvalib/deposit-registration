module ApplicationHelper

  #
  # is the current user an admin
  #
  def user_is_admin?
    return false if @current_user.blank?
    return true if ['dpg3k', 'sah', 'naw4t', 'arb5w', 'wkb5j'].include? @current_user
    return false
  end

end
