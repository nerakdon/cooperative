shared_context 'tags support' do
  let!(:tagged_on_skills_user) { FactoryGirl.create(:user, :skill_list => 'reading, riting, and rithmetic') }
  let!(:tagged_on_skills_dup) { FactoryGirl.create(:user, :skill_list => 'reading, riting, and rithmetic') }
  let!(:tagged_on_skills_trip) { FactoryGirl.create(:user, :skill_list => 'reading, riting, and rithmetic') }
  let!(:tagged_on_interests_user) { FactoryGirl.create(:user, :interest_list => 'tension, apprehension, and dissension, have-begun') }
  let!(:tagged_on_hobbies_user) { FactoryGirl.create(:user, :hobby_list => 'fee, fie, foe, fum') }

  let!(:tagged_group) { FactoryGirl.create(:group, :owner => tagged_on_skills_user, :tag_list => 'reading, apprehension, fum') }

  let!(:tagged_page) { FactoryGirl.create(:page, :pageable => tagged_on_skills_user, :tag_list => 'reading, apprehension, fum, have-begun') }

  let!(:tagged_status) { FactoryGirl.create(:status, :user => tagged_on_skills_user, :body => 'this #aint #no #disco') }

  let!(:reading_tag) { Tag.find('reading') }
end