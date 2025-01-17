require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  def basic_auth(path)
    username = ENV['BASIC_AUTH_USER']
    password = ENV['BASIC_AUTH_PASSWORD']
    visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#b{Capybara.current_session.serer.port}#{path}"
  end

  def log_in
    @user.save
    visit user_session_path
    fill_in 'email', with: "#{@user.email}"
    fill_in 'password', with: "#{@user.password}"
    click_on 'ログイン'
  end

  it 'ログアウト状態時、トップページヘッダーに、「新規登録」ボタンが表示される' do
    visit root_path
    basic_auth(root_path)
    expect(page).to have_content('新規登録')
  end
  it 'ログアウト状態時、トップページヘッダーに、「ログイン」ボタンが表示される' do
    visit root_path
    expect(page).to have_content('ログイン')
  end
  it 'ログイン状態時、トップページヘッダーに、「ユーザーのニックネーム」ボタンが表示される' do
    log_in
    expect(page).to have_content("#{@user.nickname}")
  end
  it 'ログイン状態時、トップページヘッダーに、「ログアウト」ボタンが表示される' do
    log_in
    expect(page).to have_content('ログアウト')
  end
  it 'トップページヘッダーの、「新規登録」ボタンをクリックすると、新規登録ページに遷移できる' do
    visit root_path
    click_on '新規登録'
    expect(page).to have_current_path(new_user_registration_path)
  end
  it 'トップページヘッダーの、「ログイン」ボタンをクリックすると、ログインページに遷移できる' do
    visit root_path
    click_on 'ログイン'
    expect(page).to have_current_path(user_session_path)
  end
  it 'トップページヘッダーの、「ログアウト」ボタンをクリックすると、ログアウトができる' do
    log_in
    click_on 'ログアウト'
    expect(page).to have_content('ログイン')
  end
end
