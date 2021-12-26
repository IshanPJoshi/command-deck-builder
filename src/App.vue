<template>
  <div>
    <h2>Hello {{name}}</h2>
  </div>
  <el-dropdown v-for="(c, key) in category" v-bind:key="c" style="padding:20px;">
    <el-button type="primary">
      {{key}}
    </el-button>
    <template #dropdown>
      <el-dropdown-menu>
        <el-dropdown-item v-for="item in c" v-bind:key="item">{{item}}</el-dropdown-item>
      </el-dropdown-menu>
    </template>
  </el-dropdown>

  <!-- <div class="block">
    <span class="demonstration">Default</span>
    <el-date-picker
      v-model="value3"
      type="datetimerange"
      range-separator="To"
      start-placeholder="Start date"
      end-placeholder="End date"
    >
    </el-date-picker>
  </div>
  {{value3}} -->

    
</template>

<script setup>
// import {ref} from 'vue'
let name = "Ishan"
// const value3 = ref(0)
let category = {A: ["BigA", "SmallA"],
            B: ["BigB", "SmallB"]}
</script>
<style lang="scss" scoped>
</style>