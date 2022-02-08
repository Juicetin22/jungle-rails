require 'rails_helper'

RSpec.feature "Users can navigate from the home page to a product's detail page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see one product's details" do
    # ACT
    visit root_path
    find('img', match: :first).click

    sleep 5
    # DEBUG - comment out when you don't need; for debugging only
    save_screenshot

    puts page.html

    # VERIFY
    expect(page).to have_css 'article.product-detail', count: 1
  end

end
