feature 'User sign up' do

  scenario 'I can sign up as a new user' do
    user = build(:user)
    expect { sign_up_as(user) }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'with a password that does not match' do
    user = build(:user, password_confirmation: 'wrong')
    expect { sign_up_as(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Password and confirmation password do not match'
  end

  scenario 'will fail if user does not enter an email' do
    user = build(:user, email: '')
    expect { sign_up_as(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Please enter a valid email'
  end

  def sign_up_as(user)
    visit '/users/new'
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    click_button 'Sign up'
  end


  # def sign_up(email: 'alice@example.com',
  #         password: '12345678',
  #         password_confirmation: '12345678')
  #   visit '/users/new'
  #   fill_in :email, with: email
  #   fill_in :password, with: password
  #   fill_in :password_confirmation, with: password_confirmation
  #   click_button 'Sign up'
  # end

 
  # def sign_up(email: 'alice@example.com',
  #         password: 'oranges!')
  #         visit '/users/new'
  #         expect(page.status_code).to eq(200)
  #         fill_in :email, with: email
  #         fill_in :password, with: password
  #         click_button 'Sign up'
  # end



end
