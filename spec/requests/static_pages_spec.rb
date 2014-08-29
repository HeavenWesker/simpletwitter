require 'spec_helper'


describe "Static pages" do
let(:base_title) {"Ruby on Rails Tutorial Sample App"}
  describe "Home page" do
    before { visit root_path }
    it "should have the content 'Sample App'" do 
      #visit '/static_pages/home'
      #visit root_path
      page.should have_selector('h1',
                                :text => 'Sample App')
    end 

    it "should have the right title" do 
      #visit root_path
      page.should have_selector('title',
                               :text => "#{base_title}")
    end 

    it "should not have a custom page title" do
      #visit root_path
      page.should_not have_selector('title', :text => '| Home')
    end
  end

  describe "Help page" do
    before { visit help_path }
    it "should have the content 'Help'" do 
      #visit '/static_pages/help'
      #visit help_path
      page.should have_selector('h1',
                                text => 'Help')
    end 

    it "should have the right title" do 
      #visit help_path
      page.should have_selector('title',
                               :text => "#{base_title} | Help")
    end 
  end

  describe "About page" do
    before { visit about_path }
    it "should have the content 'About Us'" do 
      #visit '/static_pages/about'
      #visit about_path
      page.should have_selector('h1',
                                text => 'About Us')
    end 

    it "should have the right title" do 
      #visit about_path
      page.should have_selector('title',
                               :text => "#{base_title} | About Us")
    end 
  end

  describe "Contact page" do
    before { visit contact_path }
    it "should have the right h1" do 
      #visit contact_path
      page.should have_selector('h1',
                               :text =>"Contact")
    end 

    it "should have the right title" do 
      #visit contact_path
      page.should have_selector('title',
                               :text => "#{base_title} | Contact Us")
    end 
  end
end
