<template>
  <div>
    <button type="button" @click="selectFile()" class="btn btn-white btn-default btn-round">
      <i class="ace-icon fa fa-upload"></i>
      {{text}}
    </button>
    <input type="file" ref="file" v-on:change="uploadFile()" v-bind:id="inputId+'-input'" class="hidden">
  </div>
</template>

<script>
  export default {
    name: 'file',
    props: {
      inputId: {
        default: "file-upload",
      },
      suffixs: {
        default: [],
      },
      use: {
        default: "",
      },
      text: {
        default: "Upload File",
      },
      afterUpload: {
          type: Function,
          default: null,
      },
      itemCount: Number // 显示的页码数，比如总共有100页，只显示10页，其它用省略号表示
    },
    data: function () {
      return {
      }
    },
    methods: {
      uploadFile() {
        let _this = this;
        let formData = new window.FormData();
        let file = _this.$refs.file.files[0];


        // 判断文件格式
        let suffixs = _this.suffixs;
        let fileName = file.name;
        let suffix = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length).toLowerCase();
        let validateSuffix = false;
        for (let i = 0; i < suffixs.length; i++) {
          if (suffixs[i].toLowerCase() === suffix) {
            validateSuffix = true;
            $("#" + _this.inputId + "-input").val("");
            break;
          }
        }
        if (!validateSuffix) {
          Toast.warning("File format is not correct, only supports:：" + suffixs.join(","));
          $("#" + _this.inputId + "-input").val("");
          return;
        }

        // key："file"必须和后端controller参数名一致
        formData.append('file', file);
        formData.append('use', _this.use);

        Loading.show();
        _this.$ajax.post(process.env.VUE_APP_SERVER + '/file/admin/upload', formData).then((response) => {
          Loading.hide();
          let resp = response.data;
          console.log("File uploaded: ", resp);
          _this.afterUpload(resp);
          $("#" + _this.inputId + "-input").val("");
        })
      },

      selectFile() {
        let _this = this;
        $("#" + _this.inputId + "-input").trigger("click");
      },
    }
  }
</script>
