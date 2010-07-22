# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  protected

  def set_date_conditions(filter, field='date')

    condition = ''
    condition += " AND #{field} >= '#{Date.strptime(filter[:from_date], DATE_FORMAT).strftime('%Y-%m-%d')}' " unless filter[:from_date].blank?
    condition += " AND #{field} <= '#{Date.strptime(filter[:to_date], DATE_FORMAT).strftime('%Y-%m-%d')}' " unless filter[:to_date].blank?

    condition
  end
end
