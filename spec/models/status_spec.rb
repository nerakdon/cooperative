require 'spec_helper'

describe Status do
  # Check that gems are installed
  # PrivatePerson gem
  it { should have_many :permissions }
  # Public Activity gem
  it { should have_many(:activities) }
  # Acts as Taggable on gem
  it { should have_many(:base_tags).through(:taggings) }
  # Coletivo gem
  it { should have_many(:person_ratings) }
  # Paperclip gem
  it { should have_attached_file(:image) }
  # Acts As Opengraph gem
  it { should respond_to(:opengraph_data) }

  # Check that appropriate fields are accessible
  it { should allow_mass_assignment_of(:body) }
  it { should allow_mass_assignment_of(:url) }
  it { should allow_mass_assignment_of(:description) }
  it { should allow_mass_assignment_of(:image_remote_url) }
  it { should allow_mass_assignment_of(:shareable_id) }
  it { should allow_mass_assignment_of(:shareable_type) }
  it { should allow_mass_assignment_of(:media_url) }
  it { should allow_mass_assignment_of(:media_type) }
  it { should allow_mass_assignment_of(:tag_list) }

  # Check that validations are happening properly
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:body) }

  # Check relationships
  it { should belong_to(:shareable) }
  it { should belong_to(:user) }
  it { should have_many(:statuses) }
  it { should have_many(:comments) }

  context 'Instance Methods' do
    include_context 'statuses support'

    describe '#build_status' do
      subject { unshared_status.build_status }
      it { should be_a_new Status }
      its(:shareable) { should be unshared_status }
    end

    describe '#image_remote_url=' do
      subject { imaged_status.image_file_name }
      it { should eq 'hqdefault.jpg' }
    end

    describe '#path' do
      subject { unshared_status.path }
      it { should eq '/statuses/' + unshared_status.id.to_s  }
    end

    describe '#tokenize_tags' do
      subject { tagged_status.tags }
      it { should have_exactly(3).items }
    end

    describe '#tokenize_mentions' do
      subject { mentioning_status }
      it { should have_exactly(3).activities }
    end

  end

end