require 'test_helper'

class SignupWithEmailAndPasswordTest < ActionDispatch::IntegrationTest

  test 'successful signup' do
    params = { signup: {
      name: 'Test User',
      email: 'signup-test@example.com',
      password: 'password'
    }}

    post '/signups', params

    assert_response :created

    # returns signup and side-loaded user record
    json = JSON.parse response.body
    assert_equal 'Test User', json['signup']['name']
    assert_equal 'signup-test@example.com', json['signup']['email']
    assert_equal 1, json['users'].length
    assert_equal 'Test User', json['users'][0]['name']
    assert_equal 'signup-test@example.com', json['users'][0]['email']
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
