<template>
  <div>
    <p>
      <button @click="add()" class="btn btn-white btn-default btn-round">
        <i class="ace-icon fa fa-edit"></i>
        Create
      </button>
      &nbsp;
      <button @click="list(1)" class="btn btn-white btn-default btn-round">
        <i class="ace-icon fa fa-refresh"></i>
        Refresh
      </button>
    </p>
    <pagination ref="pagination" v-bind:list="list"/>
    <table id="simple-table" class="table table-bordered table-hover">
      <thead>
      <tr>
        <th>id</th>

        <th>relative path</th>

        <th>file name</th>

        <th>suffix</th>

        <th>size</th>

        <th>use</th>


         <th>Operation</th>
      </tr>
      </thead>

      <tbody>
      <tr v-for="file in files">
        <td>{{file.id}}</td>
        <td>{{file.path}}</td>
        <td>{{file.name}}</td>
        <td>{{file.suffix}}</td>
        <td>{{file.size}}</td>
        <td>{{FILE_USE | optionKV(file.use)}}</td>
      <td>
        <div class="hidden-sm hidden-xs btn-group">
          <button @click="edit(file)" class="btn btn-xs btn-info">
            <i class="ace-icon fa fa-pencil bigger-120"></i>
          </button>

          <button @click="del(file.id)" class="btn btn-xs btn-danger">
            <i class="ace-icon fa fa-trash-o bigger-120"></i>
          </button>
        </div>
      </td>
      </tr>

      </tbody>
    </table>

    <div id="form-modal" class="modal fade" tabindex="-1" role="dialog">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title">Form</h4>
          </div>
          <div class="modal-body">
            <form class="form-horizontal">
                <div class="form-group">
                  <label class="col-sm-2 control-label">relative path</label>
                  <div class="col-sm-10">
                    <input v-model="file.path" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">file name</label>
                  <div class="col-sm-10">
                    <input v-model="file.name" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">suffix</label>
                  <div class="col-sm-10">
                    <input v-model="file.suffix" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">size</label>
                  <div class="col-sm-10">
                    <input v-model="file.size" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">use</label>
                  <div class="col-sm-10">
                    <select v-model="file.use" class="form-control">
                      <option v-for="o in FILE_USE" v-bind:value="o.key">{{o.value}}</option>
                    </select>
                  </div>
                </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
            <button @click="save()" type="button" class="btn btn-primary">Save</button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

  </div>
</template>

<script>
  import Pagination from "../../components/pagination.vue"
  export default {
    name: "file-file",
    components: {Pagination},
    data: function() {
      return {
        file: {},
        files: [],
        FILE_USE: FILE_USE,
      }
    },
    mounted: function() {
      let _this= this;
      _this.$refs.pagination.size = 5;
      _this.list(1);
    },
    methods: {
      // list query
      list(page) {
        let _this = this;
        Loading.show();

        _this.$ajax.post(process.env.VUE_APP_SERVER+'/file/admin/file/list', {
          page: page,
          size: _this.$refs.pagination.size,
        }).then(response => {
          Loading.hide();
          let resp = response.data;
          _this.files = resp.content.list;
          _this.$refs.pagination.render(page, resp.content.total);
        })
      },

      // click to save
      save(page) {
        let _this = this;

        // saving validation
        // 1!=1 is for solving || in the first if
        if (1 != 1
            || !Validator.require(_this.file.path, "relative path")
            || !Validator.length(_this.file.path, "relative path", 1, 100)
            || !Validator.length(_this.file.name, "file name", 1, 100)
            || !Validator.length(_this.file.suffix, "suffix", 1, 10)
        ) {
          return;
        }

        Loading.show();
        _this.$ajax.post(process.env.VUE_APP_SERVER+'/file/admin/file/save', _this.file).then(response => {
          Loading.hide();
          let resp = response.data;
          if (resp.success) {
            $("#form-modal").modal("hide");
            _this.list(1);
            Toast.success("Saved successfully!");
          } else {
            Toast.warning(resp.message);
          }
        })
      },

      // click to delete
      del(id) {
        let _this = this;
        Confirm.show("You cannot revert the deletion. Go ahead?", function () {
          Loading.show();
          _this.$ajax.delete(process.env.VUE_APP_SERVER+'/file/admin/file/delete/'+id).then(response => {
            Loading.hide();
            let resp = response.data;
            if (resp.success) {
              _this.list(1);
              Toast.success("Delete successfully!")
            }
          })
        });
      },

      add() {
        let _this = this;
        _this.file = {};
        $("#form-modal").modal("show");
      },

      // click to edit
      edit(file) {
        let _this = this;
        _this.file = $.extend({},file);
        $("#form-modal").modal("show");
      },
    }
  }
</script>
