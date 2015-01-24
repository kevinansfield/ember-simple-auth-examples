import DS from 'ember-data';

var attr = DS.attr;

export default DS.Model.extend({

  email:    attr('string'),
  name:     attr('string'),
  password: attr('string'),

  user: DS.belongsTo('user')

});
