require 'spec_helper'

describe "UserPages" do

  subject { page }

  let(:have_blank_password_error) { have_specific_error_message "Password can't be blank" }

  let(:have_short_name_error) { have_specific_error_message "Name is too short" }
  let(:have_long_name_error) { have_specific_error_message "Name is too long" }

  let(:have_blank_username_error) { have_specific_error_message "Username can't be blank" }
  let(:have_long_username_error) { have_specific_error_message "Username is too long" }

  let(:have_blank_email_error) { have_specific_error_message "Email can't be blank" }
  let(:have_invalid_email_error) { have_specific_error_message "Email is invalid" }

  let(:have_short_password_error) { have_specific_error_message "Password is too short" }
  let(:have_long_password_error) { have_specific_error_message "Password is too long" }
  let(:have_blank_confirmation_error) { have_specific_error_message "Password confirmation can't be blank" }
  let(:have_mismatch_password_error) { have_specific_error_message "Password doesn't match confirmation" }

  shared_examples_for "all invalid signups" do
    it "should not create a user" do
      expect { click_button submit }.not_to change(User, :count)
    end
  end#shared invalid

  describe "profile page" do
    let(:user)       { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before {valid_signin user}

    describe "as correct user" do
      before { visit user_path(user) }

      it { should have_selector('h1',    text: user.name) }
      it { should have_selector('title', text: user.username) }
    end

    describe "as incorrect user" do
      before { visit user_path(other_user) }

      it { should have_selector('h1',    text: 'Listing bookmarks') }
      it { should have_selector('title', text: 'Listing bookmarks') }
    end

  end#profile

  describe "signup" do
    before { visit signup_path}

    describe "page" do
      it { should have_selector('h1', text:'Sign up') }
      it { should have_selector('title', text:full_title('Sign up')) }
    end

    let(:submit) { "Create my account"}

    describe "with empty form" do
      it_should_behave_like "all invalid signups"
      describe "after submission" do
        before { click_button submit }
        it { should have_error_message '7' }
        it { should have_short_name_error }
        it { should have_blank_username_error }
        it { should have_blank_email_error }
        it { should have_invalid_email_error }
        it { should have_blank_password_error }
        it { should have_short_password_error }
        it { should have_blank_confirmation_error }
      end#after submission
    end#with empty form

    describe "with blank name" do
      before { blank_name }
      it_should_behave_like "all invalid signups"
      describe "after submission" do
        before { click_button submit }
        it { should have_error_message '1'}
        it { should have_short_name_error }
      end#after submission
    end#with no name

    describe "with short name" do
      before { short_name }
      it_should_behave_like "all invalid signups"
      describe "after submission" do
        before { click_button submit }
        it { should have_error_message '1'}
        it { should have_short_name_error }
      end#after submission
    end#with short name

    describe "with long name" do
      before { long_name }
      it_should_behave_like "all invalid signups"
      describe "after submission" do
        before { click_button submit }
        it { should have_error_message '1'}
        it { should have_long_name_error }
      end#after submission
    end#with long name

    describe "with blank username" do
      before { blank_username }
      it_should_behave_like "all invalid signups"
      describe "after submission" do
        before { click_button submit }
        it { should have_error_message '1'}
        it { should have_blank_username_error }
      end#after submission
    end#with no username

    describe "with long username" do
      before { long_username }
      it_should_behave_like "all invalid signups"
      describe "after submission" do
        before { click_button submit }
        it { should have_error_message '1'}
        it { should have_long_username_error }
      end#after submission
    end#with long username

    describe "with blank email" do
      before { blank_email }
      it_should_behave_like "all invalid signups"
      describe "after submission" do
        before { click_button submit }
        it { should have_error_message '2' }
        it { should have_blank_email_error }
        it { should have_invalid_email_error }
      end#after submission
    end#with no email

    describe "with blank passwords" do
      before { blank_passwords }
      it_should_behave_like "all invalid signups"
      describe "after submission" do
        before { click_button submit }
        it { should have_error_message '3' }
        it { should have_blank_password_error }
        it { should have_short_password_error }
        it { should have_blank_confirmation_error }
      end#after submission
    end#with no password


    describe "with long passwords" do
      before { long_passwords }
      it_should_behave_like "all invalid signups"
      describe "after submission" do
        before { click_button submit }
        it { should have_error_message '1' }
        it { should have_long_password_error }
      end#after submission
    end#with long passwords

    describe "with mismatched passwords" do
      before { password_mismatch }
      it_should_behave_like "all invalid signups"
      describe "after submission" do
        before { click_button submit }
        it { should have_error_message '1' }
        it { should have_mismatch_password_error }
      end#after submission
    end#with password doesn't match

    describe "with short passwords" do
      before { short_password }
      it_should_behave_like "all invalid signups"
      describe "after submission" do
        before { click_button submit }
        it { should have_error_message '1' }
        it { should have_short_password_error }
      end#after submission
    end#with short passwords


    describe "with valid information" do
      before { valid }
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }
        it { should have_selector('title',text: user.username) }
        it { should have_selector('div.alert.alert-success', text:'Welcome') }
        it { should_not have_link('sign in') }
      end#after saving
    end#with valid

  end#signup


  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      valid_signin user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Update your profile") }
      it { should have_selector('title', text: "Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end#page

    let(:submit) { "Save changes"}

    describe "with empty form" do
      before { blank_all }
      describe "after submission" do
        before { click_button submit }
        it { should have_error_message '6' }
        it { should have_short_name_error }
        it { should have_blank_username_error }
        it { should have_blank_email_error }
        it { should have_invalid_email_error }
        it { should have_short_password_error }
        it { should have_blank_confirmation_error }
      end#after submission
    end#with empty form

    describe "with blank name" do
      before { blank_name }
      describe "after submission" do
        before { click_button submit }
        it { should have_error_message '1'}
        it { should have_short_name_error }
      end#after submission
    end#with no name

    describe "with short name" do
      before { short_name }
      describe "after submission" do
        before { click_button submit }
        it { should have_error_message '1'}
        it { should have_short_name_error }
      end#after submission
    end#with short name

    describe "with long name" do
      before { long_name }
      describe "after submission" do
        before { click_button submit }
        it { should have_error_message '1'}
        it { should have_long_name_error }
      end#after submission
    end#with long name

    describe "with blank username" do
      before { blank_username }
      describe "after submission" do
        before { click_button submit }
        it { should have_error_message '1'}
        it { should have_blank_username_error }
      end#after submission
    end#with no username

    describe "with long username" do
      before { long_username }
      describe "after submission" do
        before { click_button submit }
        it { should have_error_message '1'}
        it { should have_long_username_error }
      end#after submission
    end#with long username

    describe "with blank email" do
      before { blank_email }
      describe "after submission" do
        before { click_button submit }
        it { should have_error_message '2' }
        it { should have_blank_email_error }
        it { should have_invalid_email_error }
      end#after submission
    end#with no email

    describe "with blank passwords" do
      before { blank_passwords }
      describe "after submission" do
        before { click_button submit }
        it { should have_error_message '2' }
        it { should have_short_password_error }
        it { should have_blank_confirmation_error }
      end#after submission
    end#with no password


    describe "with long passwords" do
      before { long_passwords }
      describe "after submission" do
        before { click_button submit }
        it { should have_error_message '1' }
        it { should have_long_password_error }
      end#after submission
    end#with long passwords

    describe "with mismatched passwords" do
      before { password_mismatch }
      describe "after submission" do
        before { click_button submit }
        it { should have_error_message '1' }
        it { should have_mismatch_password_error }
      end#after submission
    end#with password doesn't match

    describe "with short passwords" do
      before { short_password }
      describe "after submission" do
        before { click_button submit }
        it { should have_error_message '1' }
        it { should have_short_password_error }
      end#after submission
    end#with short passwords










    describe "with valid information" do
      let(:new_name)     { "New Name" }
      let(:new_username) { "New UserName" }
      let(:new_email)    { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Username",         with: new_username
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirmation",     with: user.password
        click_button "Save changes"
      end

      it { should have_selector('title', text: new_username) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('sign out', href: signout_path) }
      it { should have_link('profile', href: user_path(user)) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end#valid
  end#edit


end#UserPages
