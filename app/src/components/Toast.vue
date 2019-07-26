<template>
  <div></div>
</template>

<script>
import Toasted from "vue-toasted";
import Vue from "vue";
Vue.use(Toasted);

export default {
  mounted() {
    const subOptions = { duration: 3000 };

    this.$drizzleEvents.$on("drizzle/contractEvent", payload => {
      const { eventName } = payload;
      if (eventName === "VoteCast") {
        this.$toasted.show("Vote successfully cast!", subOptions);
      }
      if (eventName === "IssueCreated") {
        this.$toasted.show("Issue created!", subOptions);
      }
    });
  }
};
</script>
