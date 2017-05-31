import { ajax } from 'discourse/lib/ajax';

export default {
  find(opts) {
    return ajax(`/homepage`);
  }
};