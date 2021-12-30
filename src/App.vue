<template>
  <div>
    <h2>SSRL Command Deck Builder</h2>
  </div>
  <splitpanes vertical style="height: 750px" class="default-theme">
  <pane min-size="20" size="25" style="overflow-y: scroll;">
  <h3>Category</h3>
  <el-dropdown style="padding:15px">
    <el-button type="danger">
      {{selectedCat}}<el-icon class="el-icon--right"><arrow-down /></el-icon>
    </el-button>
    <template #dropdown>
      <el-dropdown-menu @click="($event) => handleCategory($event)">
        <el-dropdown-item v-for="(idx, c) in category" v-bind:key="idx" @input="($event) => handleCategory($event)">{{
          c
        }}</el-dropdown-item>
      </el-dropdown-menu>
    </template>
  </el-dropdown >
  <div style="display:block" ></div>
  <!-- v-if="categoryVals.length" -->
  <h3>Command</h3>
    <el-dropdown v-if="categoryVals.length" style="padding:15px">
      <el-button type="danger">
        {{selectedCommand}}<el-icon class="el-icon--right"><arrow-down /></el-icon>
      </el-button>
      <template #dropdown>
        <el-dropdown-menu @click="($event) => handleCommand($event)">
          <el-dropdown-item v-for="[idx,c] in categoryVals.entries()" v-bind:key="idx" >{{
            c
          }}</el-dropdown-item>
        </el-dropdown-menu>
      </template>
    </el-dropdown>
    
    <el-dropdown v-else style="padding:15px" disabled>
      <el-button type="danger">
        {{selectedCommand}}
      </el-button>
    </el-dropdown>
  <div style="display:block" ></div>
  <h3>Timeout</h3>
   <el-dropdown style="padding:15px">
    <el-button type="danger">
      {{selectedTimeout}}<el-icon class="el-icon--right" ><arrow-down /></el-icon>
    </el-button>
    <template #dropdown>
      <el-dropdown-menu @click="($event) => handleTimeout($event)">
        <el-dropdown-item>5</el-dropdown-item>
        <el-dropdown-item>10</el-dropdown-item>
        <el-dropdown-item>15</el-dropdown-item>
        <el-dropdown-item>20</el-dropdown-item>
        <el-dropdown-item>25</el-dropdown-item>
      </el-dropdown-menu>
    </template>
  </el-dropdown>
    <h3>Command Plan</h3>
  <div>
    <el-input @change="handlePlan($event)" style="width=50px"
        v-model="textarea1"
        type="textarea"

        placeholder="Please input"
      />
  </div>
    <h3>Number of Retries</h3>
   <el-dropdown style="padding:15px">
    <el-button type="danger">
      {{selectedRetries}}<el-icon class="el-icon--right" ><arrow-down /></el-icon>
    </el-button>
    <template #dropdown>
      <el-dropdown-menu @click="($event) => handleRetries($event)">
        <el-dropdown-item>1</el-dropdown-item>
        <el-dropdown-item>2</el-dropdown-item>
        <el-dropdown-item>3</el-dropdown-item>
        <el-dropdown-item>4</el-dropdown-item>
        <el-dropdown-item>5</el-dropdown-item>
      </el-dropdown-menu>
    </template>
  </el-dropdown>
  <div style="padding-bottom:20px;"/>
  <el-button @click="submitCommand"  type="danger" size="medium" round >Submit Command</el-button>
  </pane>
  <pane  min-size="40" >
    <splitpanes horizontal>
      <pane size = 15 min-size="15">
        <h3 style="padding-left:10px">Current Command</h3>
        <div style="padding-left: 14px">
        {{selectedJson}}
        </div>
      </pane>
      <pane style="overflow-y: scroll;">
        <h3 style="padding-left:10px">Full Command List</h3>
        <div style="padding-left: 14px">
        <!-- {{jsonArr}} -->
        <div v-for="[idx, elems] in jsonArr.entries()" v-bind:key="idx">
          {{elems}}
        </div>
        </div>
      </pane>
      <!-- <pane size="20">
        <div style="padding-left:10px">
        <h3>Start/End Date</h3>
        <div class="block" style="padding:15px">
          <el-date-picker
            v-model="value3"
            type="datetimerange"
            range-separator="To"
            start-placeholder="Start date"
            end-placeholder="End date"
          >
          </el-date-picker>
        </div>
        </div>
      </pane> -->
    </splitpanes>
      
  </pane>
  </splitpanes>
</template>

<script setup>
import { ArrowDown } from '@element-plus/icons-vue'
import {shallowRef, ref} from 'vue'
import { Splitpanes, Pane } from 'splitpanes'
import 'splitpanes/dist/splitpanes.css'
// let name = "Ishan"
var selectedCat = ref("Select a Category") 
var selectedCommand = ref("Select a Command") 
var selectedTimeout = ref("Timeout") 
const blankJson = shallowRef({"Command": "", "Arguments": {"Timeout": "","Command Plan": "", "# of Retries": ""}})
var selectedJson = ref({"Command": "", "Arguments": {"Timeout": "","Command Plan": "", "# of Retries": ""}})
var jsonArr = ref([])
var selectedRetries = ref("# of retries") 
var categoryVals = ref([])
var textarea1 = ref('')
// const value3 = ref("")
let category = {A: ["BigA", "SmallA"],
            B: ["BigB", "SmallB"]}

const handleCategory = (blk) => {
  // let temp = blankJson
  selectedJson.value = {"Command": "", "Arguments": {"Timeout": "","Command Plan": "", "# of Retries": ""}}
  selectedCat.value = blk.target.innerText
  selectedCommand.value = "Select a Command"
  selectedTimeout.value = "Timeout"
  textarea1.value = ""
  selectedRetries.value = "# of retries"
  // console.log("category", selectedCat)
  categoryVals.value = category[selectedCat.value]
  // console.log("cat",categoryVals.value)

}
const handleCommand = (blk) => {

  selectedJson.value = {"Command": "", "Arguments": {"Timeout": "","Command Plan": "", "# of Retries": ""}}
  selectedCommand.value = blk.target.innerText
  let temp = selectedJson.value
  selectedTimeout.value = "Timeout"
  textarea1.value = ""
  selectedRetries.value = "# of retries"
  temp['Command'] = selectedCommand.value
  selectedJson.value = temp
  // console.log("command", selectedCat)
  // categoryVals.value = category[selectedCat]

}
const handleTimeout = (blk) => {

  selectedTimeout.value = blk.target.innerText
  if(selectedTimeout.value != "Timeout"){
    let temp = selectedJson.value
    temp['Arguments']['Timeout'] = selectedTimeout.value
    selectedJson.value = temp
  }

}

const handlePlan = (blk) => {

  let temp = selectedJson.value
  temp['Arguments']['Command Plan'] = blk
  selectedJson.value = temp
}

const handleRetries = (blk) => {

  selectedRetries.value = blk.target.innerText
  let temp = selectedJson.value
  temp['Arguments']['# of Retries'] = selectedRetries.value
  selectedJson.value = temp
  // console.log("command", selectedCat)
  // categoryVals.value = category[selectedCat]

}

const submitCommand = () => {
  let temp = jsonArr.value
  let temp2 = selectedJson.value
  temp.push(temp2)
  jsonArr.value = temp
  selectedJson.value = blankJson
  selectedCat.value = "Select a Category"
  selectedCommand.value = "Select a Command"
  selectedTimeout.value = "Timeout"
  textarea1.value = ""
  selectedRetries.value = "# of retries"
  selectedJson.value = blankJson.value
}
</script>
<style lang="scss" scoped>
</style>