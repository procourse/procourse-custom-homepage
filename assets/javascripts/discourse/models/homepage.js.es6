import { ajax } from 'discourse/lib/ajax';
import { default as PrettyText, buildOptions } from 'pretty-text/pretty-text';

const Homepage = Discourse.Model.extend(Ember.Copyable, {

  init: function() {
    this._super();
  }
});

function getOpts() {
  const siteSettings = Discourse.__container__.lookup('site-settings:main');

  return buildOptions({
    getURL: Discourse.getURLWithCDN,
    currentUser: Discourse.__container__.lookup('current-user:main'),
    siteSettings
  });
}

var HomepageObject = Ember.Object;

Homepage.reopenClass({

  find: function(){
    var homepage = HomepageObject.create({ content: {}, loading: true, disableSave: false });
    ajax("/dl-custom-homepage/admin/homepage.json").then(function(result) {
      homepage.set('content', {
        raw: result.raw,
        cooked: result.cooked
      });
      homepage.set('loading', false);
    });
    return homepage;
  },

  save: function(object) {
    if (object.get('disableSave')) return;
    
    object.set('savingStatus', I18n.t('saving'));
    object.set('saving',true);

    var data = {};

    if (object) {
      var cooked = new Handlebars.SafeString(new PrettyText(getOpts()).cook(object.content.raw));
      data.raw = object.content.raw;
      data.cooked = cooked.string;
    };

    return ajax("/dl-custom-homepage/admin/homepage.json", {
      data: JSON.stringify({"homepage": data}),
      type: 'PUT',
      dataType: 'json',
      contentType: 'application/json'
    }).then(function(result) {
      object.set('savingStatus', I18n.t('saved'));
      object.set('saving', false);
    });
  }
});

export default Homepage;