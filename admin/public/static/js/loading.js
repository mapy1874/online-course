Loading = {
  show: function () {
    $.blockUI({
      message: '<img src="/static/image/loading.gif">',
      css: {
        padding: "10px",
        left: "50%",
        width: "80px",
        marginLeft: "-40px",
      }
    });
  },
  hide: function () {
    // searching speed is too fast, add a latency deliberately
    setTimeout(function () {
      $.unblockUI();
    }, 500)
  }
}