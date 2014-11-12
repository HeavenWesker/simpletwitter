require 'spec_helper'

describe "PasswordResets" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  describe "password reset page" do
    before { visit new_password_reset_path }
    it { should have_selector('title',  text: 'Reset Password') }
    it { should have_selector('h1',  text: 'Reset Password') }
    describe "click_button" do
      describe "with valid email" do
        before { click_button "Reset Password" }
        it { should have_selector("h1", text: "Reset Password")}
      end
      describe "with valid email" do
        before do
          fill_in "email", with: user.email
          click_button "Reset Password"
        end
        it { should have_selector("h1", text: "Welcome to Simple Twitter")}
        it { should have_content("sent")}
      end
    end
  end
end
