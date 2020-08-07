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
        <th>ID</th>
        <th>title</th>
        <th>course.id</th>
        <th>chapter.id</th>
        <th>video</th>
        <th>time (s)</th>
        <th>charge or not</th>
        <th>order</th>
        <th>created time</th>
        <th>revision time</th>
         <th>Operation</th>
      </tr>
      </thead>

      <tbody>
      <tr v-for="section in sections">
        <th>{{section.id}}</th>
        <th>{{section.title}}</th>
        <th>{{section.courseId}}</th>
        <th>{{section.chapterId}}</th>
        <th>{{section.video}}</th>
        <th>{{section.time}}</th>
        <th>{{section.charge}}</th>
        <th>{{section.sort}}</th>
        <th>{{section.createdAt}}</th>
        <th>{{section.updatedAt}}</th>
      <td>
        <div class="hidden-sm hidden-xs btn-group">
          <button @click="edit(section)" class="btn btn-xs btn-info">
            <i class="ace-icon fa fa-pencil bigger-120"></i>
          </button>

          <button @click="del(section.id)" class="btn btn-xs btn-danger">
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
                <label class="col-sm-2 control-label">ID</label>
                <div class="col-sm-10">
                  <input v-model="section.id" type="text" class="form-control">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">title</label>
                <div class="col-sm-10">
                  <input v-model="section.title" type="text" class="form-control">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">course.id</label>
                <div class="col-sm-10">
                  <input v-model="section.courseId" type="text" class="form-control">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">chapter.id</label>
                <div class="col-sm-10">
                  <input v-model="section.chapterId" type="text" class="form-control">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">video</label>
                <div class="col-sm-10">
                  <input v-model="section.video" type="text" class="form-control">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">time (s)</label>
                <div class="col-sm-10">
                  <input v-model="section.time" type="text" class="form-control">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">charge or not</label>
                <div class="col-sm-10">
                  <input v-model="section.charge" type="text" class="form-control">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">order</label>
                <div class="col-sm-10">
                  <input v-model="section.sort" type="text" class="form-control">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">created time</label>
                <div class="col-sm-10">
                  <input v-model="section.createdAt" type="text" class="form-control">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">revision time</label>
                <div class="col-sm-10">
                  <input v-model="section.updatedAt" type="text" class="form-control">
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
    name: "section",
    components: {Pagination},
    data: function() {
      return {
      section: {},
      sections: [],
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

        _this.$ajax.post(process.env.VUE_APP_SERVER+'/business/admin/section/list', {
          page: page,
          size: _this.$refs.pagination.size,
        }).then(response => {
          Loading.hide();
          let resp = response.data;
          _this.sections = resp.content.list;
          _this.$refs.pagination.render(page, resp.content.total);
        })
      },

      // click to save
      save(page) {
        let _this = this;

        // saving validation
        // 1!=1 is for solving || in the first if
        if (1 != 1
            || !Validator.require(_this.section.title, "title")
            || !Validator.length(_this.section.title, "title", 1, 50)
            || !Validator.length(_this.section.video, "video", 1, 200)
        ) {
          return;
        }

        Loading.show();
        _this.$ajax.post(process.env.VUE_APP_SERVER+'/business/admin/section/save', _this.section).then(response => {
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
          _this.$ajax.delete(process.env.VUE_APP_SERVER+'/business/admin/section/delete/'+id).then(response => {
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
        _this.section = {};
        $("#form-modal").modal("show");
      },

      // click to edit
      edit(section) {
        let _this = this;
        _this.section = $.extend({},section);
        $("#form-modal").modal("show");
      },
    }
  }
</script>
