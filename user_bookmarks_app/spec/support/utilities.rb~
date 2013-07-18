include ApplicationHelper

def valid_signin(user)
  visit signin_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  cookies[:remember_token] = user.remember_token
end

def fill_form(user_in)
                             # if (object has key){ user_in[:name] }else{ 'Example User' }
  fill_in "Username",     with: user_in.key?(:username) ? user_in[:username] : 'Example'
  fill_in "Name",         with: user_in.key?(:name) ? user_in[:name] : 'Example User'
  fill_in "Email",        with: user_in.key?(:email) ? user_in[:email] : 'user@example.com'
  fill_in "Password",     with: user_in.key?(:password) ? user_in[:password] : 'foobarr'
  fill_in "Confirmation", with: user_in.key?(:confirmation) ? user_in[:confirmation] : 'foobarr'
end

def blank_all
  fill_form ( { username:nil, name:nil, email:nil, password:nil, confirmation:nil } )
end

def valid
  fill_form ( { } )
end

def blank_name
  fill_form ( { name: nil } )
end

def short_name
  fill_form ( { name: 'a'*1 } )
end

def long_name
  fill_form ( { name: 'a'*76 } )
end

def blank_username
  fill_form ( { username: nil } )
end

def long_username
  fill_form ( { username: 'a'*21 } )
end

def blank_email
  fill_form ( { email: nil } )
end

def blank_passwords
  fill_form ({ password: nil, confirmation: nil})
end

def long_passwords
  fill_form ({ password: 'a'*41, confirmation: 'a'*41 })
end

def password_mismatch
  fill_form ({ password: 'a'*7, confirmation: 'b'*7 })
end

def short_password
  fill_form ({ password: 'a'*3, confirmation: 'a'*3 })
end


RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_specific_error_message do |message|
  match do |page|
    page.should have_selector('div#error_explanation ul', text: message)
  end
end
