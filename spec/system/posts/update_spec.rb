
require 'rails_helper'

RSpec.describe 'update a post', type: :system do
  before(:each) do
    @user1 = User.create(:username => "Andrew", :email => "achalkley@example.com") 
    @user2 = User.create(:username => "Matt", :email => "mtardivo@example.com") 

    @post = Post.create(:user => @user1, :title => "My Blog Post", :body => "Hello world!\n\nThis is my first blog post.")
  end

  ###TODO: complete this scenario 100% controller coverage
  ###Ability to change the author from Andrew to Matt

  scenario 'empty title and body' do
    visit edit_post_path(@post)

    fill_in "Title", with: ""
    fill_in "Body", with: ""

    click_button 'Update Post'

    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")

    expect(@post.reload.title).to eq("My Blog Post")
    expect(@post.reload.body).to eq("Hello world!\n\nThis is my first blog post.")
  end

  scenario 'edit author' do
    visit edit_post_path(@post)
    select @user2.username, from: "post[user_id]"

    click_button 'Update Post'

    expect(page).to have_content("Post was successfully updated.")

    expect(@post.reload.user).to eq(@user2)
  end

  scenario 'edit title and body' do
    visit edit_post_path(@post)
    fill_in "Title", with: "Updated title"
    fill_in "Body", with: "A new body for my post"

    click_button 'Update Post'

    expect(page).to have_content("Updated title")
    expect(page).to have_content("By: Andrew")
    expect(page).to have_content("A new body for my post")

    expect(@post.reload.title).to eq("Updated title")
    expect(@post.reload.body).to eq("A new body for my post")
  end
  
end
