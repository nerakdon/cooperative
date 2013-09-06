require 'spec_helper'

describe PagesController do
  routes { Cooperative::Engine.routes }

  describe 'routing' do
    it { should route(:get, '/').to(:action => 'index') }
    it { should route(:get, '/pages/parent').to(:action => 'show', :path => 'parent') }
    it { should route(:get, '/pages/parent/child').to(:action => 'show', :path => 'parent/child') }

    for nicknamed_nesting_resource in %w{people}
      it { should route(:get, "/#{nicknamed_nesting_resource}/nickname/pages").to(:action => 'index', "#{nicknamed_nesting_resource.singularize}_id".to_sym => 'nickname') }
      it { should route(:get, "/#{nicknamed_nesting_resource}/nickname/pages/foo").to(:action => 'show', "#{nicknamed_nesting_resource.singularize}_id".to_sym => 'nickname', :path => 'foo') }
      it { should route(:get, "/#{nicknamed_nesting_resource}/nickname/pages/new").to(:action => 'new', "#{nicknamed_nesting_resource.singularize}_id".to_sym => 'nickname') }
      it { should route(:post, "/#{nicknamed_nesting_resource}/nickname/pages").to(:action => 'create', "#{nicknamed_nesting_resource.singularize}_id".to_sym => 'nickname') }
      it { should route(:get, "/#{nicknamed_nesting_resource}/nickname/pages/1/edit").to(:action => 'edit', "#{nicknamed_nesting_resource.singularize}_id".to_sym => 'nickname', :id => 1) }
      it { should route(:put, "/#{nicknamed_nesting_resource}/nickname/pages/1").to(:action => 'update', "#{nicknamed_nesting_resource.singularize}_id".to_sym => 'nickname', :id => 1) }
      it { should route(:delete, "/#{nicknamed_nesting_resource}/nickname/pages/1").to(:action => 'destroy', "#{nicknamed_nesting_resource.singularize}_id".to_sym => 'nickname', :id => 1) }
    end
  end

  pending 'GET index'
  pending 'GET show'
  pending 'GET new'
  pending 'POST create'
  pending 'GET edit'
  pending 'PUT update'
  pending 'DELETE destroy'

end