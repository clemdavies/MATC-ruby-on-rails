require 'spec_helper'

describe "Bookmarks" do

  subject { page }

  describe "index" do


    describe "as signed out user" do
      before { visit root_path }
      it { should have_selector('h1',    text: "Sign in" ) }
      it { should have_selector('title', text: "Sign in" ) }
    end

    describe "as signed in user" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        valid_signin user
        visit root_path
      end
      it { should have_selector('h1',    text: "Listing bookmarks") }
      it { should have_selector('title', text: "Listing bookmarks") }
    end

  end

  describe "show" do
    let(:user) { FactoryGirl.create(:user) }
    let(:bookmark) { FactoryGirl.create(:bookmark, user: user) }

    before do
      valid_signin user
      visit '/bookmarks/'+bookmark.id.to_s
    end

    it { should have_selector('h1', text: bookmark.name) }
    it { should have_selector('p', text: bookmark.url) }
    it { should have_selector('p', text: bookmark.name) }

  end#show

  describe "edit" do



  end#edit

  describe "new" do



  end#new

end#Bookmarks
