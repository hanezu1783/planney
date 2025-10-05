class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    # 新規登録時(sign_up時)にnicknameというキーのパラメーターを許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end
