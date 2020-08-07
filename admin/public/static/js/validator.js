Validator = {
  require: function (value, text) {
    if (Tool.isEmpty(value)) {
      Toast.warning(text + " cannot be empty");
      return false;
    } else {
      return true;
    }
  },

  length: function (value, text, min, max) {
    if (Tool.isEmpty(value)) {
      return true;
    }
    if(!Tool.isLength(value, min, max)) {
      Toast.warning("The length of "+text+" should between "+min+" and "+max);
      return false;
    } else {
      return true;
    }
  }
}