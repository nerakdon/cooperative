module Cooperative
  def self.configure(configuration = Cooperative::Configuration.new)
    if block_given?
      yield configuration
    end
    @@configuration = configuration
  end
  
  def self.configuration
    @@configuration ||= Cooperative::Configuration.new
  end
  
  class Configuration
    attr_accessor :application_name, :application_description, :application_keywords, :tinymce_options,
                  :paperclip_options
    
    def initialize
      self.application_name = "TODO"
      self.application_description = "TODO"
      self.application_keywords = "TODO"
      self.tinymce_options = {
        :mode => 'specific_textareas',
        :editor_selector => 'wysiwyg'
      }
      self.paperclip_options = {
        :user => {:large => "600x400>", :medium => "300x200>", :thumb => "150x100>"},
        :statuses => {:large => "600x600>", :medium => "300x300>", :thumb => "150x150>"}
      }
    end
  end
end