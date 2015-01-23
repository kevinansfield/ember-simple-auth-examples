# Ember Simple Auth Examples

A playground for testing Ember Simple Auth and Rails integration with various authentication providers.

This purposefully does not use Devise as I wanted to drop the dependency and keep all authentication details up-front and visible on the rails side.


## Setup

```
$ cd api
$ bundle install
$ cd ../frontend
$ npm install
$ bower install
```

## Running

Rails server:

```
$ cd api
$ rails s
```

Ember server:

```
$ cd frontend
$ ember serve
```

It will automatically proxy to http://0.0.0.0:3000 for api calls.
