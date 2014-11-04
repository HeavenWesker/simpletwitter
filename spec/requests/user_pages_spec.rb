require 'spec_helper'

describe "UserPages" do
  subject { page }
  describe "Sign up page" do
    before { visit signup_path }
    it { should have_selector('h1',     text: "Sign up") }
    it { should have_selector('title',  text: full_title('Sign up')) }
  end
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    it { user.should_not be_nil}
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "foo") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "bar") }
    before do
      sign_in user
      visit user_path(user) 
    end 
    it { should have_selector("h1",    text:   user.name) }
    it { should have_selector("title", text:   user.name) }
    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end
    describe "follow/unfollow buttons" do
      let(:other_user) { FactoryGirl.create(:user) }
      before do
        visit user_path(other_user)
      end
      describe "following a user" do
        it "should increment the followed user count" do
          expect do
            click_button "Follow"
          end.to change(user.followed_users, :count).by(1)
        end
        it "should increment the other user's followers count" do
          expect do
            visit user_path(other_user)
            click_button "Follow"
          end.to change(other_user.followers, :count).by(1)
        end
        describe "toggling the button" do
          before { click_button "Follow" }
          it { should have_selector('input', value: 'Unfollow') }
        end
      end
      describe "unfollowing a user" do
        before do
          user.follow!(other_user)
          visit user_path(other_user)
        end
        it "should decrement the followed user count" do
          expect do
            click_button "Unfollow"
          end.to change(user.followed_users, :count).by(-1)
        end
        it "should decrement the other user's followers user count" do
          expect do
            click_button "Unfollow"
          end.to change(other_user.followers, :count).by(-1)
        end
        describe "toggling the button" do
          before { click_button "Unfollow" }
          it { should have_selector('input', value: 'Follow') }
        end
      end
    end
  end

  describe "SignupPages" do
    before { visit signup_path }
    let(:submit) { "Create my account"}
    describe "with invalid information" do
      it "should not create account" do
        expect {click_button submit }.not_to change(User, :count)
      end
      describe "after click submit button" do
        before { click_button submit }
        it { should have_content("error") }
        it { should have_selector('title', text: "Sign up") }
      end
    end
    describe "with valid information" do
      before do
        fill_in "Name",           with: "Example"
        fill_in "Email",          with: "user@example.com"
        fill_in "Password",       with: "foobar"
        fill_in "Password confirmation",   with: "foobar"
      end
      it "should create account" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      describe "after click submit button" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }
        it { should have_selector('title', text:user.name) }
        it { should have_selector('div.alert.alert-success', text:"Welcome") }
      end
      describe "after saving the user" do
        before { click_button submit }
        it { should have_link('Sign out') }
      end
    end 
  end

  describe "following/followers" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before { user.follow!(other_user) }
    describe "following" do
      before do
        sign_in user
        visit following_user_path(user)
      end
      it { should have_selector('title',        text: full_title("Following")) }
      it { should have_selector('h3',           text: "Following") }
      it { should have_link(other_user.name,    href: user_path(other_user)) }
    end
    describe "followers" do
      before do
        sign_in other_user
        visit followers_user_path(other_user)
      end
      it { should have_selector('title',        text: full_title("Followers")) }
      it { should have_selector('h3',           text: "Followers") }
      it { should have_link(user.name,          href: user_path(user)) }
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) } 
    before do
      sign_in user
      visit edit_user_path(user) 
    end
    describe "page" do
      it { should have_selector('h1', text: "Update your profile") }
      it { should have_selector('title', text: "Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end
    describe "with invalid information" do 
      before { click_button "Save changes" } 
      it { should have_content('error') }
    end 
  end
  describe "edit" do
    let(:user)    { FactoryGirl.create(:user) }
    let(:submit)  { "Save changes" }
    before do 
      sign_in user
      visit edit_user_path(user) 
    end
    describe "page" do
      it { should have_selector('h1',     text:   'Update your profile') }
      it { should have_selector('title',  text:   'Edit user') }
      it { should have_link('change',     href:   "http://gravatar.com/emails") }
    end
    describe "with invalid information" do
      before { click_button submit }
      it { should have_content('error') }
    end
  end
  describe "index" do 
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Boboooo", email: "bob@example.com") 
      FactoryGirl.create(:user, name: "Bennnnn", email: "ben@example.com") 
      visit users_path
    end
    it { should have_selector('title', text: 'All users') } 
    it { should have_selector('h1', text: 'All users') }
    it "should list each user" do
      User.all.each do |user|
        page.should have_selector('li', text: user.name)
      end 
    end
    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all}
      it { should have_selector("div.pagination") }
      it "should list each user" do
        User.paginate(page: 1).each do |user|
          should have_selector('li', text: user.name)
        end
      end
    end
    describe "delete links" do
      it { should_not have_link('delete')}
      describe "as admin user" do
          let(:admin){ FactoryGirl.create(:admin) }
        before do
          click_link "Sign out"
          sign_in admin
          visit users_path
        end
        it { should have_link('delete', href: user_path(User.first)) }
        it "should not delete self" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        describe "should not delete self" do
          it { should_not have_link('delete', href: user_path(admin)) }
        end
        describe "submitting a DELETE request to the Users#destroy action" do
          before { delete user_path(admin) }
          specify { response.should redirect_to(root_path) }
        end
      end
    end
  end
end
