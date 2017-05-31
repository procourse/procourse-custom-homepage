export default {
  resource: 'admin.adminPlugins',
  path: '/plugins',
  map() {
    this.route('dl-custom-homepage');
  }
};