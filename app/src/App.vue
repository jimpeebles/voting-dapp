<template>
  <div id="app">
    <make-issue />
    <view-issues />
  </div>
</template>

<script>
import MakeIssue from "@/components/MakeIssue";
import ViewIssues from "@/components/ViewIssues";
export default {
  components: {
    MakeIssue,
    ViewIssues
  }
};
</script>

<style lang="scss">
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
