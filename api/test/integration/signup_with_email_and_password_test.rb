require 'test_helper'

class SignupWithEmailAndPasswordTest < ActionDispatch::IntegrationTest

  test 'successful signup' do
    params = { signup: {
      name: 'Test User',
      email: 'test@example.com',
      password: 'password'
    }}

    post '/signups', params

    assert_response :created

    # returns signup and side-loaded user record
    expected_response = {
      'signup' => {
        'id' => 1,
        'name' => 'Test User',
        'email' => 'test@example.com',
        'user_id' => 1
      },
      'users' => [
        {
          'id' => 1,
          'name' => 'Test User',
          'email' => 'test@example.com'
        }
      ]
    }

    returned_json = JSON.parse response.body
    assert_equal expected_response, returned_json
  end

  test 'unsuccessful signup' do
    params = { signup: {
      name: '',
      email: '',
      password: ''
    }}

    post '/signups', params

    assert_response :unprocessable_entity

    expected_response = {
      'name' => ["can't be blank"],
      'email' => ["can't be blank"],
      'password' => ["can't be blank"]
    }

    returned_json = JSON.parse response.body
    assert_equal expected_response, returned_json
  end

end
