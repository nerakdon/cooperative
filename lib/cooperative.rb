module Cooperative
  require 'rails'
  require 'rails-i18n'
  
  require 'rspec'
  require 'capybara'
  require 'factory_girl_rails'
  require 'database_cleaner'
  require 'rails-dev-boost'
  
  require 'cooperative/configuration'
  require 'cooperative/railtie'
  require 'cooperative/engine'
  require 'cooperative/localization'
  require 'cooperative/version'
  require 'cooperative/models/permission_extension'

  require 'haml'
  require 'haml-rails'
  require 'sass-rails'
  require 'bootstrap-sass'
  require 'font-awesome-sass-rails'
  require 'bootstrap_forms'
  require 'breadcrumbs_on_rails'

  require 'jquery-rails'
  require 'jquery-ui-rails'
  require 'jquery-ui-bootstrap-rails-asset'
  require 'tinymce-rails'

  require 'bootstrap_pager'

  require 'cancan'
  require 'devise'
  require 'authorization'
  require 'private_person'

  require 'paperclip'
  require 'nokogiri'
  require 'friendly_id'
  require 'public_activity'
  require 'acts_as_follower'
  require 'acts-as-taggable-on'
  require 'coletivo'
end