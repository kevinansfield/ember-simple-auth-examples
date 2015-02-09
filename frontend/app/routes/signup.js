import Ember from 'ember';

export default Ember.Route.extend({

  model: function() {
    return this.store.createRecord('signup');
  },

  actions: {
    signup: function() {
      console.log('signup entered');
      var signup = this.modelFor('signup');
      var authenticator = 'simple-auth-authenticator:oauth2-password-grant';

      var email = signup.get('email');
      var password = signup.get('password');

      return signup.save().then(() => {
        console.log('signup saved');
        console.log('authenticating');
        return this.get('session').authenticate(authenticator, {
          identification: email,
          password: password
        }).then(() => {
          console.log('authenticated');
          console.log('transitioning to "index"');
          this.transitionTo('index');
        }).catch((error) => {
          console.log('authentication failed', error);
        });
      });
    }
  }

});
