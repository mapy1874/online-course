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

        <th>name</th>

        <th>nickname</th>

        <th>image</th>

        <th>position</th>

        <th>motto</th>

        <th>intro</th>
         <th>Operation</th>
      </tr>
      </thead>

      <tbody>
      <tr v-for="teacher in teachers">
        <td>{{teacher.id}}</td>
        <td>{{teacher.name}}</td>
        <td>{{teacher.nickname}}</td>
        <td>{{teacher.image}}</td>
        <td>{{teacher.position}}</td>
        <td>{{teacher.motto}}</td>
        <td>{{teacher.intro}}</td>
      <td>
        <div class="hidden-sm hidden-xs btn-group">
          <button @click="edit(teacher)" class="btn btn-xs btn-info">
            <i class="ace-icon fa fa-pencil bigger-120"></i>
          </button>

          <button @click="del(teacher.id)" class="btn btn-xs btn-danger">
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
                  <label class="col-sm-2 control-label">name</label>
                  <div class="col-sm-10">
                    <input v-model="teacher.name" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">nickname</label>
                  <div class="col-sm-10">
                    <input v-model="teacher.nickname" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">image</label>
                  <div class="col-sm-10">
                    <input v-model="teacher.image" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">position</label>
                  <div class="col-sm-10">
                    <input v-model="teacher.position" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">motto</label>
                  <div class="col-sm-10">
                    <input v-model="teacher.motto" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">intro</label>
                  <div class="col-sm-10">
                    <input v-model="teacher.intro" class="form-control">
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
    name: "business-teacher",
    components: {Pagination},
    data: function() {
      return {
        teacher: {},
        teachers: [],
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

        _this.$ajax.post(process.env.VUE_APP_SERVER+'/business/admin/teacher/list', {
          page: page,
          size: _this.$refs.pagination.size,
        }).then(response => {
          Loading.hide();
          let resp = response.data;
          _this.teachers = resp.content.list;
          _this.$refs.pagination.render(page, resp.content.total);
        })
      },

      // click to save
      save(page) {
        let _this = this;

        // saving validation
        // 1!=1 is for solving || in the first if
        if (1 != 1
            || !Validator.require(_this.teacher.name, "name")
            || !Validator.length(_this.teacher.name, "name", 1, 50)
            || !Validator.length(_this.teacher.nickname, "nickname", 1, 50)
            || !Validator.length(_this.teacher.image, "image", 1, 100)
            || !Validator.length(_this.teacher.position, "position", 1, 50)
            || !Validator.length(_this.teacher.motto, "motto", 1, 50)
            || !Validator.length(_this.teacher.intro, "intro", 1, 500)
        ) {
          return;
        }

        Loading.show();
        _this.$ajax.post(process.env.VUE_APP_SERVER+'/business/admin/teacher/save', _this.teacher).then(response => {
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
          _this.$ajax.delete(process.env.VUE_APP_SERVER+'/business/admin/teacher/delete/'+id).then(response => {
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
        _this.teacher = {};
        $("#form-modal").modal("show");
      },

      // click to edit
      edit(teacher) {
        let _this = this;
        _this.teacher = $.extend({},teacher);
        $("#form-modal").modal("show");
      },
    }
  }
</script>
