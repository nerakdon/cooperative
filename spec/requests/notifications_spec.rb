require 'spec_helper'

describe "Notifications" do
  include_context "notifications support"
  include_context "login support for requests"

  it "has a link in the navbar" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    visit cooperative.home_path
    click_link :notifications.l
  end

  it "has a list of followed peoples' activities" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    visit cooperative.notifications_path
    page.should have_selector '.activity', :minimum => 5
    page.should_not have_selector '.activity', :text => 'private'
  end

end