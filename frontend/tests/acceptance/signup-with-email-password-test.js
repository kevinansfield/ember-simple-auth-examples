import Ember from 'ember';
import startApp from '../helpers/start-app';
import Pretender from 'pretender';

var application;
var server;

module('Acceptance: Email/Password signup', {
  setup: function() {
    application = startApp();
    server = new Pretender(function() {
      this.post("/signups", function(request) {
        var data = JSON.parse(request.requestBody);

        var result = {
          signup: {
            id: 1,
            email: data.signup.email,
            name: data.signup.name,
            user_id: 1
          },
          users: [
            {
              id: 1,
              email: data.signup.email,
              name: data.signup.name
            }
          ]
        };

        return [201, {"Content-Type": "application/json"}, JSON.stringify(result)];
      });

      this.post("/token", function(request) {
        var data = JSON.parse(request.requestBody);
        console.log('"/token" called with:', data);
        var result;

        if (data.username === 'test@example.com' && data.password === 'password') {
          result = {
            access_token: 'f49fc36c3a0c0f70d0ee13ed129b01ed',
            token_type: 'bearer'
          };
          return [200, {"Content-Type": "application/json"}, JSON.stringify(result)];
        } else {
          result = {
            error: "Username or password is invalid"
          };
          return [401, {"Content-Type": "application/json"}, JSON.stringify(result)];
        }
      });
    });
  },
  teardown: function() {
    Ember.run(application, 'destroy');
    server.shutdown();
  }
});

test('visiting /signup', function() {
  visit('/signup');

  andThen(function() {
    equal(currentPath(), 'signup');
  });
});

test('logs in and redirects to index after successful signup', function() {
  visit('/signup');
  fillIn('#signup-email', 'test@example.com');
  fillIn('#signup-name', 'Test User');
  fillIn('#signup-password', 'password');
  click('#signup-submit');

  andThen(function() {
    console.log('andThen entered');
    equal(currentPath(), 'index');
    equal(find('a:contains("Logout")').length, 1);
  });
});
