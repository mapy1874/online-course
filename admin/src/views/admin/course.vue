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
    <div class="row">
      <div class="col-md-4" v-for="course in courses">
        <div class="thumbnail search-thumbnail">
          <img v-show="!course.image" class="media-object" src="https://img2.mukewang.com/szimg/5e26a9f909ef95b512000676-360-202.png" />
          <img v-show="course.image" class="media-object" v-bind:src="course.image" />
          <div class="caption">
            <div class="clearfix">
              <span class="pull-right label label-primary info-label">
                {{COURSE_LEVEL | optionKV(course.level)}}
              </span>
              <span class="pull-right label label-primary info-label">
                {{COURSE_CHARGE | optionKV(course.charge)}}
              </span>
              <span class="pull-right label label-primary info-label">
                {{COURSE_STATUS | optionKV(course.status)}}
              </span>
            </div>

            <h3 class="search-title">
              <a href="#" class="blue">{{course.name}}</a>
            </h3>
            <p>
              <span class="blue bolder bigger-150"><i class="fa fa-dollar"></i>&nbsp;{{course.price}}</span>
            </p>
            <p>{{course.summary}}</p>
            <p>
              <span class="badge badge-info">{{course.id}}</span>
              <span class="badge badge-info">Sort：{{course.sort}}</span>
              <span class="badge badge-info">Length：{{course.time | formatSecond}}</span>
            </p>
            <p>
              <button @click="edit(course)" class="btn btn-xs btn-white btn-info btn-round">
                Edit
              </button>
              <button @click="del(course.id)" class="btn btn-xs btn-white btn-info btn-round">
                Delete
              </button>
              <button @click="toChapter(course)" class="btn btn-xs btn-white btn-info btn-round">
                Chapter
              </button>
            </p>
          </div>
        </div>
      </div>
    </div>

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
                    <input v-model="course.name" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">summary</label>
                  <div class="col-sm-10">
                    <input v-model="course.summary" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">time</label>
                  <div class="col-sm-10">
                    <input v-model="course.time" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">price (CNY)</label>
                  <div class="col-sm-10">
                    <input v-model="course.price" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">cover</label>
                  <div class="col-sm-10">
                    <input v-model="course.image" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">level</label>
                  <div class="col-sm-10">
                    <select v-model="course.level" class="form-control">
                      <option v-for="o in COURSE_LEVEL" v-bind:value="o.key">{{o.value}}</option>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">Charge</label>
                  <div class="col-sm-10">
                    <select v-model="course.charge" class="form-control">
                      <option v-for="o in COURSE_CHARGE" v-bind:value="o.key">{{o.value}}</option>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">Status</label>
                  <div class="col-sm-10">
                    <select v-model="course.status" class="form-control">
                      <option v-for="o in COURSE_STATUS" v-bind:value="o.key">{{o.value}}</option>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">enrollment</label>
                  <div class="col-sm-10">
                    <input v-model="course.enroll" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">sort</label>
                  <div class="col-sm-10">
                    <input v-model="course.sort" class="form-control">
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
    name: "business-course",
    components: {Pagination},
    data: function() {
      return {
        course: {},
        courses: [],
        COURSE_LEVEL: COURSE_LEVEL,
        COURSE_CHARGE: COURSE_CHARGE,
        COURSE_STATUS: COURSE_STATUS,
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

        _this.$ajax.post(process.env.VUE_APP_SERVER+'/business/admin/course/list', {
          page: page,
          size: _this.$refs.pagination.size,
        }).then(response => {
          Loading.hide();
          let resp = response.data;
          _this.courses = resp.content.list;
          _this.$refs.pagination.render(page, resp.content.total);
        })
      },

      // click to save
      save(page) {
        let _this = this;

        // saving validation
        // 1!=1 is for solving || in the first if
        if (1 != 1
            || !Validator.require(_this.course.name, "name")
            || !Validator.length(_this.course.name, "name", 1, 50)
            || !Validator.length(_this.course.summary, "summary", 1, 2000)
            || !Validator.length(_this.course.image, "cover", 1, 100)
        ) {
          return;
        }

        Loading.show();
        _this.$ajax.post(process.env.VUE_APP_SERVER+'/business/admin/course/save', _this.course).then(response => {
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
          _this.$ajax.delete(process.env.VUE_APP_SERVER+'/business/admin/course/delete/'+id).then(response => {
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
        _this.course = {};
        $("#form-modal").modal("show");
      },

      // click to edit
      edit(course) {
        let _this = this;
        _this.course = $.extend({},course);
        $("#form-modal").modal("show");
      },

      // jump to chapter
      toChapter(course) {
        let _this = this;
        SessionStorage.set("course", course);
        _this.$router.push("/business/chapter")
      },
    }
  }
</script>

<style scoped>
  .caption h3 {
    font-size: 20px;
  }
</style>