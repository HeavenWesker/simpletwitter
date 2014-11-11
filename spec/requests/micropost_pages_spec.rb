require 'spec_helper'

describe "MicropostPages" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  describe "micropost creation" do
    before { visit root_path }
    describe "with invalid information" do
      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end
    end
    describe "error messages" do
      before { click_button "Post" }
      it { should have_content("error") }
    end
    describe "with valid information" do
      before { fill_in "micropost_content", with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end
  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }
    describe "as correct user" do
      before do
        #sign_out
        click_link "Sign out"
        sign_in user 
      end
      it "should delete a micropost" do
        expect { click_link 'delete' }.to change(Micropost, :count).by(-1)
      end
    end
  end
  describe "micropost message" do
    before { visit root_path }
    describe "with invalid information" do
      it "should not create a message" do
        expect { click_button "Post" }.not_to change(Message, :count)
      end
    end
    describe "error messages" do
      before { click_button "Post" }
      it { should have_content("error") }
    end
    describe "with valid information" do
      let(:other_user) { FactoryGirl.create(:user) }
      before { fill_in "micropost_content", with: "d @#{other_user.id_name} A Message" }
      it "should create a message" do
        expect { click_button "Post" }.to change(Message, :count).by(1)
      end
    end
  end
end
