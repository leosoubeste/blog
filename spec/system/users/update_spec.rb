
require 'rails_helper'

RSpec.describe 'update a user', type: :system do
  ###TODO: complete this spec 100% controller coverage
  before(:each) do
    @user1 = User.create(:username => "Andrew", :email => "achalkley@example.com") 
    @user2 = User.create(:username => "Leo", :email => "leosoubeste@example.com") 
  end

  scenario 'empty username and email' do
    visit edit_user_path(@user1)

    fill_in "Username", with: ""
    fill_in "Email", with: ""

    click_button 'Update User'

    expect(page).to have_content("Username can't be blank")
    expect(page).to have_content("Email can't be blank")

    expect(@user1.reload.username).to eq("Andrew")
    expect(@user1.reload.email).to eq("achalkley@example.com")
  end

  scenario 'invalid email' do
    visit edit_user_path(@user1)
    fill_in "Email", with: "invalid@email"
    click_button 'Update User'

    expect(page).to have_content("Email is invalid")

    expect(@user1.reload.username).to eq("Andrew")
    expect(@user1.reload.email).to eq("achalkley@example.com")
  end

  scenario 'valid user details' do
    visit edit_user_path(@user2)
    fill_in "Username", with: "Leo Soubeste"
    fill_in "Email", with: "leosoubeste@other.com"
    click_button 'Update User'

    expect(page).to have_content("User was successfully updated.")
    expect(page).to have_content("Leo Soubeste")
    expect(page).to have_content("leosoubeste@*****.com")

    expect(@user2.reload.username).to eq("Leo Soubeste")
    expect(@user2.reload.email).to eq("leosoubeste@other.com")
  end
end
