# Be sure to restart your server when you modify this file.
#
# Points are a simple integer value which are given to "meritable" resources
# according to rules in +app/models/merit/point_rules.rb+. They are given on
# actions-triggered, either to the action user or to the method (or array of
# methods) defined in the +:to+ option.
#
# 'score' method may accept a block which evaluates to boolean
# (recieves the object as parameter)

module Merit
  class PointRules
    include Merit::PointRulesMethods

    def initialize
      # score 10, :on => 'users#update' do
      #   user.name.present?
      # end
      #
      # score 15, :on => 'reviews#create', :to => [:reviewer, :reviewed]
      #
      # score 20, :on => [
      #   'comments#create',
      #   'photos#create'
      # ]
      #score 10, to: :post_creator, on: 'comments#create' do |comment|
      #  comment.title.present?
      #end
      #
      #score 20, on: [
      #    'comments#create',
      #    'photos#create'
      #]
      #
      #score 15, on: 'reviews#create', to: [:reviewer, :reviewed]
      
      score 10, :to => :user, :on => 'pages#create' do |page|
        page.title.present? and page.body.present?
      end
      
      score -10, :to => :user, :on => 'pages#destroy'
      
      score 1, :to => :user, :on => 'statuses#create' do |status|
        status.body.present?
      end
      
      score -1, :to => :user, :on => 'statuses#destroy'
      
      score 5, :to => :followed, :on => 'follows#create'
      
      score -5, :to => :followed, :on => 'follows#destroy'
      
    end
  end
end