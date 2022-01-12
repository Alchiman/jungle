require 'rails_helper'

RSpec.feature "Product Details", type: :feature, js: true do
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
  scenario "User can go to the product details page from the home page " do

  visit root_path

  first('a.btn.btn-default').click

    # DEBUG
    save_and_open_screenshot

    # VERIFY
    expect(page).to have_content 'Apparel'
  end


end
