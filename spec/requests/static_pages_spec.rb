require 'spec_helper'

describe "Static pages" do

	let(:base_title) { "Ruby on Rails Tutorial Sample App" }
	
  # Set the subject for the tests
  subject { page }

  describe "Home page" do

    before { visit root_path }

     # old method to hard-code in relative location of the file
     #visit '/static_pages/home'


    # Long form of tests
    # it "should have the content 'Sample App'" do
    #   expect(page).to have_content('Sample App')
    # end

    # it "should have the base title" do
    #   expect(page).to have_title("Ruby on Rails Tutorial Sample App")
    # end

    # it "should not have a custom page title" do
    #   expect(page).not_to have_title('| Home')
    # end

    it { should have_content('Sample App') }

    # full_title is in the spec/support/utilities.rb file
    it { should have_title(full_title('')) }

    it { should_not have_title('| Home') }

  end	# end describe "Home page"


  describe "Help page" do

    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }

  end	# end describe "Help page"


  describe "About page" do

    before { visit about_path }

    it { should have_content('About Us') }
    it { should have_title(full_title('About Us')) }

  end	# end describe "About page"


	describe "Contact page" do

    before { visit contact_path }

    it { should have_content('Contact Us') }
    it { should have_title(full_title('Contact Us')) }

  end	# end describe "Contact page"


end