require 'rails_helper'

RSpec.describe Post, type: :feature do
  it 'should get posts form' do
    visit posts_path
    expect(page).to have_link 'New Post'
    click_link 'New Post'
    expect(page).to have_css('form[action="/posts"]')
  end

  it 'should create a new post' do
    visit new_post_path
    fill_in 'Title', with: 'First Post'
    fill_in 'Content', with: 'Lorem Ipsum'
    click_button 'Create Post'

    expect(page).to have_content 'Post was successfully created.'
  end

  it 'should list the created posts on the homepage' do
    visit new_post_path
    fill_in 'Title', with: 'First Post'
    fill_in 'Content', with: 'Lorem Ipsum'
    click_button 'Create Post'

    visit posts_path
    expect(page).to have_xpath '//tbody/tr', count: Post.count
  end

  it 'should edit the created post' do
    post = Post.create(title: 'First Post', content: 'Lorem Ipsum')

    visit edit_post_path(post)
    fill_in 'Title', with: post.title + ' Edited'
    fill_in 'Content', with: post.content + ' Edited'
    click_button 'Update Post'

    expect(page).to have_content 'Post was successfully updated.'
    expect(page).to have_content 'First Post Edited'
    expect(page).to have_content 'Lorem Ipsum Edited'
  end

  it 'should deleted the post' do
    post = Post.create(title: 'First Post', content: 'Lorem Ipsum')

    visit posts_path
    expect(page).to have_content post.title
    find("a[data-method='delete'][href='#{post_path(post)}']").click
    expect(page).to have_content 'Post was successfully destroyed.'
  end
end
