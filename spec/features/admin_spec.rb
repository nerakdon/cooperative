require 'spec_helper'

describe "Admin" do
  include_context "login support for requests"
  include_context "pages support"

  it "requires login" do
    visit rails_admin.dashboard_url
    current_url.should eq new_user_session_url
  end

  it "does not provide access to dashboard to non-admin users" do
    user = FactoryGirl.create(:user)
    # Note that the user is not an admin at this point.

    sign_in user

    visit rails_admin.dashboard_url
    current_url.should == cooperative.home_url
    page.should have_selector '.alert-warning', :count => 1
  end

  it "provides access to dashboard to admin users" do
    user = FactoryGirl.create(:user)
    user.is_admin
    # Note that the user is now an admin

    sign_in user

    visit rails_admin.dashboard_path
    current_url.should == rails_admin.dashboard_url
    page.should have_selector '.navbar', :count => 1
  end

  it "provides access to pages" do
    user = FactoryGirl.create(:user)
    sign_in_as_admin user

    visit rails_admin.dashboard_path
    find('.sidebar-nav').click_link "Pages"
  end

  it "provides access to users" do
    user = FactoryGirl.create(:user)
    sign_in_as_admin user

    visit rails_admin.dashboard_path
    find('.sidebar-nav').click_link "Users"
  end

  it "uses base configuration from cooperative" do
    user = FactoryGirl.create(:user)
    sign_in_as_admin user

    visit rails_admin.dashboard_path
    page.should have_selector '.brand', :text => /^#{Cooperative.configuration.application_name}/
  end
end