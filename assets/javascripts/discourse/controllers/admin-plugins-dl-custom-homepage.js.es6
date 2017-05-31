import Page from '../models/homepage';
import { licensed } from 'discourse/plugins/dl-custom-homepage/discourse/lib/constraint';

export default Ember.Controller.extend({

  licensed: licensed(),

  changed: function(){
    if (!this.get('originals') || !this.get('selectedItem')) {this.set('disableSave', true); return;}
    if (((this.get('originals').title == this.get('selectedItem').title) &&
      (this.get('originals').slug == this.get('selectedItem').slug) &&
      (this.get('originals').raw == this.get('selectedItem').raw) &&
      (this.get('originals').cooked == this.get('selectedItem').cooked)) ||
      (!this.get('selectedItem').title) ||
      (!this.get('selectedItem').raw)
    ) {
      this.set('disableSave', true); 
      return;
    }
    else{
      this.set('disableSave', false);
    };
  }.observes('selectedItem.title', 'selectedItem.slug', 'selectedItem.raw'),

  actions: {

    save: function() {
      Page.save(this.get('model'));
    }
  }
});