Tool = {
  isEmpty: function (obj) {
    if ((typeof obj == 'string')) {
      return !obj || obj.replace(/\s+/g, "") == "";
    } else {
      return (!obj || JSON.stringify(obj) === "{}" || obj.length === 0);
    }
  },

  isNotEmpty: function (obj) {
    return !this.isEmpty();
  },

  // length validation
  isLength: function (str, min, max) {
    return $.trim(str).length >= min && $.trim(str).length <= max;
  }
}