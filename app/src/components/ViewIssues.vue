<template>
  <section>
    <div>Issues: {{ issueCount }}</div>
    <div
      v-for="(issue, id) in issueList"
      :key="id"
      class="issueCard"
      :data-id="id"
    >
      <div class="title">{{ issue.title }}</div>
      <div class="choices">
        <div
          class="choicebox"
          v-for="(key, value) in issue.choices"
          :key="value"
          @click="castVote($event, value)"
        >
          <div class="choice">{{ value }}</div>
          <div class="tally">{{ key }}</div>
        </div>
      </div>
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
      methodArgs: [],
      issueList: []
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
  watch: {
    issueData(data) {
      if (typeof data === "object") {
        data.forEach((issue, index) => {
          if (this.issueList[index] === undefined) {
            this.issueList[index] = new Object();
            this.issueList[index].title = this.utils.toUtf8(issue);
          } else {
            this.issueList[index].title = this.utils.toUtf8(issue);
          }
        });
      }
    },
    choiceData(data) {
      if (typeof data === "object") {
        data.forEach((choice, index) => {
          let choiceAr = this.utils.toUtf8(choice).split(",");
          choiceAr.forEach(c => {
            if (this.issueList[index].choices === undefined) {
              this.issueList[index].choices = new Object();
            }
            if (
              this.issueList[index].choices[c] === null ||
              this.issueList[index].choices[c] > 0
            )
              return;
            this.issueList[index].choices[c] = 0;
          });
        });
      }
    },
    votes(data) {
      if (typeof data === "object") {
        let ids = data[0];
        let hexChoices = data[2];
        let choices = hexChoices.map(choice => {
          return this.utils.toUtf8(choice);
        });
        choices.forEach((choice, i) => {
          this.issueList[ids[i]].choices[choice] = 0;
        });
        choices.forEach((choice, i) => {
          this.issueList[ids[i]].choices[choice] += 1;
        });
      }
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
    castVote(event, value) {
      const id = event.target.parentElement.parentElement.parentElement.getAttribute(
        "data-id"
      );
      const convertedChoice = this.utils.toHex(value);
      // Construct arguments
      const sendArgs = [convertedChoice, id];
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

.choicebox {
  display: flex;
  text-align: left;
}
.choice {
  flex: 1;
}
.choice:hover {
  color: blue;
  cursor: pointer;
}
.tally {
  min-width: 40px;
  justify-self: right;
}
</style>
