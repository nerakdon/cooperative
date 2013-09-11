class CooperativeController < ActionController::Base
  include Rails.application.routes.url_helpers
  include Rails.application.routes.mounted_helpers

  protect_from_forgery
  before_filter :set_locale

  rescue_from CanCan::AccessDenied, :with => :not_found
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  
  #add_breadcrumb :home.l, '/'

  def not_found
    render :status => 404, :layout => 'cooperative', :file => "#{Rails.root}/public/404"
  end

private
  def set_locale
    I18n.local = params[:lang] if params[:lang].present?
  end

  def access_denied (exception)
    redirect_to cooperative.home_url, :alert => exception.message
  end
  
  def polymorphic_parent_class
    polymorphic_resource.classify.constantize
  end

  def polymorphic_parent_name
    polymorphic_resource.capitalize.singularize
  end

  def polymorphic_parent_id
    params[(polymorphic_resource.singularize + '_id').to_sym]
  end

  def polymorphic_parent
    polymorphic_parent_class.find(polymorphic_parent_id)
  end

  def polymorphic_resource
    params[:nesting_resource] || request.fullpath.split('/')[1]
  end
end
