module APIHelper
  extend Grape::API::Helpers


  def current_user
    token = params[:token]
    token = User.digest(token)
    @current_user ||= User.where(token: token).first
  end

  def authenticate!
    error!({error: "401 Unauthorized"}, 401) unless current_user
  end


  params :pagination do
    optional :page, type: Integer
    optional :per_page, type: Integer
  end


end