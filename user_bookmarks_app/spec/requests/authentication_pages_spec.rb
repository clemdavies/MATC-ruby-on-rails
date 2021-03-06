require 'spec_helper'

describe "AuthenticationPages" do

  subject { page }

  describe "signin" do
    before { visit signin_path }

    describe "page" do
      it { should have_selector('h1',    text: 'Sign in') }
      it { should have_selector('title', text: 'Sign in') }
    end# page

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('title', text: 'Sign in') }
      it { should have_error_message 'Invalid' }

      describe "after visiting another page" do
        before { visit root_path }
        it { should_not have_error_message 'Invalid' }
      end

    end#invalid

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }

      before { valid_signin(user) }

      it { should have_selector('title', text: user.username) }

      it { should have_link('sign out', href: signout_path) }
      it { should have_link('profile', href: user_path(user)) }
      it { should_not have_link('sign up', href: signup_path) }

      describe "followed by visiting profile" do
        before { click_link "profile" }

        it { should have_selector('title', text: user.username) }
        it { should have_link('sign out', href: signout_path) }
        it { should have_link('profile', href: user_path(user)) }
        it { should_not have_link('sign up', href: signup_path) }
      end


      describe "followed by signout" do
        before { click_link "sign out" }
        it { should have_link('sign up', href: signup_path) }
      end#signout

    end#valid

  end#signin


  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end

      end#users controller


      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.should have_selector('title', text: 'Edit user')
          end
        end
      end



    end#non-signed-in


    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { valid_signin user }

      #describe "visiting Users#edit page" do
      #  before { visit edit_user_path(wrong_user) }
      #  it { should_not have_selector('title', text: full_title('Edit user')) }
      #end#visit edit
      #
      #describe "submitting a PUT request to the Users#update action" do
      #  before { put user_path(wrong_user) }
      #  specify { response.should redirect_to(root_path) }
      #
      #end#put update

    end#wrong user

  end#authorization



end
