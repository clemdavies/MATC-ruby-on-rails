require 'spec_helper'

describe "bookmarks/new" do
  before(:each) do
    assign(:bookmark, stub_model(Bookmark,
      :url => "mytestvalue.com",
      :name => "mytestname",
      :date_saved => "testday"
    ).as_new_record)
  end

  it "renders new bookmark form" do
    render


    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => bookmarks_path, :method => "post" do
      assert_select "input#bookmark_url", :name => ":bookmark[url]"
      assert_select "input#bookmark_name", :name => ":bookmark[name]"
      assert_select "input#bookmark_date_saved", :name => ":bookmark[date_saved]"
    end

  end
end
