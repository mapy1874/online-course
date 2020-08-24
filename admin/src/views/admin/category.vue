<template>
  <div>
    <div class="row">
      <div class="col-md-6">
        <p>
          <button v-on:click="add1()" class="btn btn-white btn-default btn-round">
            <i class="ace-icon fa fa-edit"></i>
            Create Level 1
          </button>
          <button @click="all()" class="btn btn-white btn-default btn-round">
            <i class="ace-icon fa fa-refresh"></i>
            Refresh
          </button>
        </p>

        <table id="level1-table" class="table  table-bordered table-hover">
          <thead>
          <tr>
            <th>id</th>
            <th>name</th>
            <th>sort</th>
            <th>operations</th>
          </tr>
          </thead>

          <tbody>
          <tr v-for="category in level1" @click="onClickLevel1(category)" v-bind:class="{'active' : active.id===category.id}">
            <td>{{category.id}}</td>
            <td>{{category.name}}</td>
            <td>{{category.sort}}</td>
            <td>
              <div class="hidden-sm hidden-xs btn-group">
                <button v-on:click="edit(category)" class="btn btn-xs btn-info">
                  <i class="ace-icon fa fa-pencil bigger-120"></i>
                </button>
                <button v-on:click="del(category.id)" class="btn btn-xs btn-danger">
                  <i class="ace-icon fa fa-trash-o bigger-120"></i>
                </button>
              </div>
            </td>
          </tr>
          </tbody>
        </table>
      </div>

      <div class="col-md-6">
        <p>
          <button v-on:click="add2()" class="btn btn-white btn-default btn-round">
            <i class="ace-icon fa fa-edit"></i>
            Create Level 2
          </button>
        </p>

        <table id="level2-table" class="table  table-bordered table-hover">
          <thead>
          <tr>
            <th>id</th>
            <th>name</th>
            <th>sort</th>
            <th>operations</th>
          </tr>
          </thead>

          <tbody>
          <tr v-for="category in level2">
            <td>{{category.id}}</td>
            <td>{{category.name}}</td>
            <td>{{category.sort}}</td>
            <td>
              <div class="hidden-sm hidden-xs btn-group">
                <button v-on:click="edit(category)" class="btn btn-xs btn-info">
                  <i class="ace-icon fa fa-pencil bigger-120"></i>
                </button>
                <button v-on:click="del(category.id)" class="btn btn-xs btn-danger">
                  <i class="ace-icon fa fa-trash-o bigger-120"></i>
                </button>
              </div>
            </td>
          </tr>
          </tbody>
        </table>
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
                  <label class="col-sm-2 control-label">parent category</label>
                  <div class="col-sm-10">
                    <p class="form-control-static">{{active.name || "None"}}</p>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">name</label>
                  <div class="col-sm-10">
                    <input v-model="category.name" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">sort</label>
                  <div class="col-sm-10">
                    <input v-model="category.sort" class="form-control">
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
  export default {
    name: "business-category",
    data: function() {
      return {
        category: {},
        categorys: [],
        level1: [],
        level2: [],
        active: {},
      }
    },
    mounted: function() {
      let _this= this;
      _this.all();
    },
    methods: {
      // query all
      all() {

        let _this = this;
        Loading.show();

        _this.$ajax.post(process.env.VUE_APP_SERVER+'/business/admin/category/all').then(response => {
          Loading.hide();
          let resp = response.data;
          _this.categorys = resp.content;
          // 将所有记录格式化成树形结构
          _this.level1 = [];
          for (let i = 0; i < _this.categorys.length; i++) {
            let c = _this.categorys[i];
            if (c.parent === '00000000') {
              _this.level1.push(c);
              for (let j = 0; j < _this.categorys.length; j++) {
                let child = _this.categorys[j];
                if (child.parent === c.id) {
                  if (Tool.isEmpty(c.children)) {
                    c.children = [];
                  }
                  c.children.push(child);
                }
              }
            }
          }
        })
      },


      // click to save
      save() {
        let _this = this;

        // saving validation
        // 1!=1 is for solving || in the first if
        if (1 != 1
            || !Validator.require(_this.category.parent, "parent_id")
            || !Validator.require(_this.category.name, "name")
            || !Validator.length(_this.category.name, "name", 1, 50)
        ) {
          return;
        }

        Loading.show();
        _this.$ajax.post(process.env.VUE_APP_SERVER+'/business/admin/category/save', _this.category).then(response => {
          Loading.hide();
          let resp = response.data;
          if (resp.success) {
            $("#form-modal").modal("hide");
            _this.all();
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
          _this.$ajax.delete(process.env.VUE_APP_SERVER+'/business/admin/category/delete/'+id).then(response => {
            Loading.hide();
            let resp = response.data;
            if (resp.success) {
              _this.all();
              Toast.success("Delete successfully!")
            }
          })
        });
      },

      onClickLevel1(category) {
        let _this = this;
        _this.level2 = category.children;
        _this.active = category;
      },

      // click to create level 1
      add1() {
        let _this = this;
        _this.active = {};
        _this.level2 = [];
        _this.category = {
          parent: "00000000",
        };
        $("#form-modal").modal("show");
      },

      // click to create level 2
      add2() {
        let _this = this;
        if (Tool.isEmpty(_this.active)) {
          Toast.warning("Please click level 1 category first.");
          return;
        }
        _this.category = {
          parent: _this.active.id,
        };
        $("#form-modal").modal("show");
      },

      // click to edit
      edit(category) {
        let _this = this;
        _this.category = $.extend({},category);
        $("#form-modal").modal("show");
      },
    }
  }
</script>

<style scoped>
  .active td {
    background-color: #d6e9c6 !important;
  }
</style>