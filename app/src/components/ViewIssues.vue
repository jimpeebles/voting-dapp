<template>
  <section>
    <div v-for="issue in issues" :key="issue.id" class="issueCard">
      <div class="title">{{ issue.issueText }}</div>
    </div>
    <div>Issues: {{ issueCount }}</div>
  </section>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  data() {
    return {
      issues: [
        {
          id: 0,
          issueText:
            "How many licks does it take to get to the center of a tootsie pop?",
          votes: {
            "100": 521,
            "1000": 53,
            "10000": 369
          }
        }
      ],
      contractName: "Issues",
      getIssueCountMethod: "getIssueCount",
      methodArgs: []
    };
  },
  computed: {
    ...mapGetters("contracts", ["getContractData", "contractInstances"]),

    issueCount() {
      const arg = {
        contract: this.contractName,
        method: this.getIssueCountMethod
      };
      let count = this.getContractData(arg);
      return count;
    }
  },

  created() {
    const { contractName, getIssueCountMethod } = this;
    const args = "";
    console.log(args);
    this.$store.dispatch("drizzle/REGISTER_CONTRACT", {
      contractName,
      getIssueCountMethod,
      args
    });
  }
};
</script>

<style scoped>
.title {
  font-size: 1.2em;
  font-weight: bold;
}
.issueContainer {
  display: flex;
}
.issueCard {
  width: 100%;
  max-width: 300px;
  min-height: 300px;
  box-shadow: 0 0 5px 0 grey;
  padding: 1rem;
}
</style>
