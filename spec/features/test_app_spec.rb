require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'test app routing', :type => :feature do
  it "redirects to a path with an id" do
    visit "/"
    click_link "Diane Abbott"
    expect(page).to have_current_path("/people/7TX8ySd4")
  end

  it "redirects to index path Mps" do
    visit "/"
    click_link "MPs"
    expect(page).to have_current_path("/mps")
  end
end
