Confirm = {
  show: function (meassage, callback) {
    Swal.fire({
      title: 'Are you sure?',
      text: meassage,
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
      if (result.value) {
        if (callback) {
          callback();
        }
      }
    });
  }
}
