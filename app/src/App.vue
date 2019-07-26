<template>
  <div id="app" v-if="isDrizzleInitialized">
    <make-issue />
    <view-issues />
  </div>
  <div class="loading" v-else>Loading Issues</div>
</template>

<script>
import MakeIssue from "@/components/MakeIssue";
import ViewIssues from "@/components/ViewIssues";
import { mapGetters } from "vuex";

export default {
  name: "App",
  components: {
    MakeIssue,
    ViewIssues
  },
  computed: {
    ...mapGetters("drizzle", ["isDrizzleInitialized"])
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
.loading {
  height: 100vh;
  font-size: 3em;
  color: #000;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
