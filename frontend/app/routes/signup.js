import Ember from 'ember';

export default Ember.Route.extend({

  model: function() {
    return this.store.createRecord('signup');
  },

  actions: {
    signup: function() {
      var self = this;
      var signup = this.modelFor('signup');

      signup.save().then(function(signup) {
        // TODO: replace with actual session service
        var user = signup.get('user');
        self.controllerFor('application').set('session', {});
        self.controllerFor('application').set('session.user', user);
        self.transitionTo('index');
      });
    }
  }

});
