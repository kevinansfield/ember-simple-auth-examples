import Ember from 'ember';
import startApp from '../helpers/start-app';
import Pretender from 'pretender';

var application;
var server;

module('Acceptance: Email/Password signup', {
  setup: function() {
    application = startApp();
    server = new Pretender(function() {
      this.post("/api/signups", function(request) {
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
  fillIn('#signup-email', 'test@xample.com');
  fillIn('#signup-name', 'Test User');
  fillIn('#signup-password', 'password');
  click('#signup-submit');

  andThen(function() {
    equal(currentPath(), 'index');
    equal(find('span:contains("Test User")').length, 1);
  });
});
