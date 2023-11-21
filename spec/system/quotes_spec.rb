require 'rails_helper'

RSpec.describe "Quotes", type: :system do
  before do
    driven_by(:rack_test)
    @quote = create(:quote, name: 'My first quote')
  end

  it 'Creating a new quote' do
    visit quotes_path

    expect(page).to have_content 'Quotes'

    click_link 'New Quote'
    expect(page).to have_content "New quote"

    fill_in "Name", with: "Capybara quote"
    click_button "Create quote"

    expect(page).to have_content "Quotes"
    expect(page).to have_content "Capybara quote"
  end

  it "Showing quote" do
    visit quotes_path

    click_on @quote.name

    expect(page).to have_content @quote.name
  end

  it "Updating quote" do
    visit quotes_path

    expect(page).to have_content "Quotes"
    click_link "Edit", match: :first

    fill_in "Name", with: "Updated quote"
    click_on "Update quote"

    expect(page).to have_content "Quotes"
    expect(page).to have_content "Updated quote"
  end

  it "Deleted quote" do
    visit quotes_path
    expect(page).to have_content @quote.name

    click_on "Delete", match: :first
    expect(page).to_not have_content @quote.name
  end
end
