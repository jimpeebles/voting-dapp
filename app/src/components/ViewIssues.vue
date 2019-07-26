<template>
  <section>
    <div>Issues: {{ issueCount }}</div>
    <div v-for="(row, index) in issueData" :key="index" class="issueCard">
      <div class="title">{{ utils.toUtf8(row) }}</div>
      <ul>
        <li
          v-for="(r, i) in utils.toUtf8(choiceData[index]).split(',')"
          :key="i"
          @click="castVote(r, index)"
        >
          {{ r }}
        </li>
      </ul>
    </div>
  </section>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  data() {
    return {
      contractName: "Issues",
      method: "getIssueCount",
      methodArgs: []
    };
  },
  computed: {
    ...mapGetters("contracts", ["getContractData", "contractInstances"]),
    ...mapGetters("drizzle", ["drizzleInstance", "isDrizzleInitialized"]),
    utils() {
      return this.drizzleInstance.web3.utils;
    },

    issueCount() {
      const arg = {
        contract: this.contractName,
        method: this.method
      };
      let count = this.getContractData(arg);
      return count;
    },
    issueData() {
      const arg = {
        contract: this.contractName,
        method: "getIssues"
      };
      let issues = this.getContractData(arg);
      return issues;
    },
    choiceData() {
      const arg = {
        contract: this.contractName,
        method: "getChoices"
      };
      let choices = this.getContractData(arg);
      return choices;
    },
    votes() {
      const arg = {
        contract: this.contractName,
        method: "getVotes"
      };
      let votes = this.getContractData(arg);
      return votes;
    }
  },
  methods: {
    registerContract(contractName, method, methodArgs) {
      const contractData = {
        contractName,
        method,
        methodArgs
      };
      this.$store.dispatch("drizzle/REGISTER_CONTRACT", contractData);
    },
    castVote(choice, issueId) {
      const convertedChoice = this.utils.toHex(choice);

      // Construct arguments
      const sendArgs = [convertedChoice, issueId];

      // Send
      this.drizzleInstance.contracts[this.contractName].methods[
        "castVote"
      ].cacheSend(...sendArgs);
    }
  },
  created() {
    this.registerContract("Issues", "getIssueCount", "");
    this.registerContract("Issues", "getIssues", "");
    this.registerContract("Issues", "getChoices", "");
    this.registerContract("Issues", "getVotes", "");
    this.registerContract("Issues", "getVotes", "");
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
  padding: 40px 0px;
}
.issueCard {
  display: inline-block;
  width: 100%;
  max-width: 300px;
  min-height: 300px;
  box-shadow: 0 0 5px 0 grey;
  padding: 1rem;
  margin: 1rem;
  box-sizing: border-box;
}
ul {
  padding: 0;
}
ul,
li {
  list-style: none;
}
li:hover {
  color: blue;
  cursor: pointer;
}
</style>
