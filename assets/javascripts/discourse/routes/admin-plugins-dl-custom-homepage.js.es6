import Page from '../models/homepage';

export default Discourse.Route.extend({
  model() {
    return Page.find();
  },

  setupController(controller, model) {
    controller.setProperties({ model });
  }
});