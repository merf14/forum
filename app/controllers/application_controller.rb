class ApplicationController < ActionController::Base
  around_action :set_locale_param

  private

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale_param(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
