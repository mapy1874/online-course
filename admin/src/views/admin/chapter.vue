<template>
  <div>
    <h4 class="lighter">
      <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue"></i>
      <router-link to="/business/course" class="pink"> {{course.name}} </router-link>
    </h4>
    <hr>
    <p>
      <router-link to="/business/course" class="btn btn-white btn-default btn-round">
        <i class="ace-icon fa fa-arrow-left"></i>
        Return to course
      </router-link>
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
        <th>ID</th>
        <th>Name</th>
        <th>Operation</th>
      </tr>
      </thead>

      <tbody>
      <tr v-for="chapter in chapters">
        <td>{{chapter.id}}</td>
        <td>{{chapter.name}}</td>
        <td>
          <div class="hidden-sm hidden-xs btn-group">
            <button @click="edit(chapter)" class="btn btn-white btn-xs btn-info btn-round">
              Edit
            </button>&nbsp;

            <button @click="del(chapter.id)" class="btn btn-white btn-warning btn-xs btn-round">
              Delete
            </button>&nbsp;

            <button @click="toSection(chapter)" class="btn btn-white btn-xs btn-info btn-round">
              Section
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
                <label class="col-sm-2 control-label">Name</label>
                <div class="col-sm-10">
                  <input v-model="chapter.name" type="text" class="form-control" placeholder="Name">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">Course</label>
                <div class="col-sm-10">
                  <p class="form-control-static">{{course.name}}</p>
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
    name: "chapter",
    components: {Pagination},
    data: function() {
      return {
        chapter: {},
        chapters: [],
        course: {},
      }
    },
    mounted: function() {
      let _this= this;
      _this.$refs.pagination.size = 5;
      // null.name is error. {}.name isn't
      let course = SessionStorage.get("course") || {};
      if (Tool.isEmpty(course)) {
        _this.$router.push("/welcome");
      }
      _this.course = course;
      _this.list(1);
    },
    methods: {
      // list query
      list(page) {
        let _this = this;
        Loading.show();

        _this.$ajax.post(process.env.VUE_APP_SERVER+'/business/admin/chapter/list', {
          page: page,
          size: _this.$refs.pagination.size,
          courseId: _this.course.id,
        }).then(response => {
          Loading.hide();
          let resp = response.data;
          _this.chapters = resp.content.list;
          _this.$refs.pagination.render(page, resp.content.total);
        })
      },

      // click to save
      save(page) {
        let _this = this;
        if (!Validator.require(_this.chapter.name, "Name")
          || !Validator.length(_this.chapter.courseId, "course ID", 1, 8)) {
          return;
        }
        _this.chapter.courseId = _this.course.id;
        Loading.show();
        _this.$ajax.post(process.env.VUE_APP_SERVER+'/business/admin/chapter/save', _this.chapter).then(response => {
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
            _this.$ajax.delete(process.env.VUE_APP_SERVER+'/business/admin/chapter/delete/'+id).then(response => {
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
        _this.chapter = {};
        $("#form-modal").modal("show");
      },

      // click to edit
      edit(chapter) {
        let _this = this;
        _this.chapter = $.extend({},chapter);
        $("#form-modal").modal("show");
      },

      toSection(chapter) {
        let _this = this;
        SessionStorage.set("chapter", chapter);
        _this.$router.push("/business/section");
      },
    }
  }
</script>
