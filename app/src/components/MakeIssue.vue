<template>
  <section v-if="isDrizzleInitialized">
    <h2>Create An Issue</h2>

    <textarea
      name="issueText"
      cols="50"
      rows="6"
      placeholder="What color should the city paint the bike shed?"
      v-model="issueText"
    >
    </textarea>
    <h2>Add Choices</h2>
    <div class="add-choice">
      <input type="text" v-model="choiceInput" placeholder="Red" />
      <button @click="addChoice">Add</button>
    </div>
    <div class="choices">
      <ol>
        <li v-for="(choice, index) in choices" :key="index">{{ choice }}</li>
      </ol>
    </div>
    <button id="submitIssue" @click.prevent="submitIssue">Create Issue</button>
  </section>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  data() {
    return {
      choiceInput: "",
      choices: [],
      contractName: "Issues",
      contractMethod: "createIssue",
      issueText: ""
    };
  },
  computed: {
    ...mapGetters("drizzle", ["drizzleInstance", "isDrizzleInitialized"]),

    utils() {
      return this.drizzleInstance.web3.utils;
    }
  },
  methods: {
    addChoice() {
      this.choices.push(this.choiceInput);
      this.choiceInput = "";
    },
    submitIssue() {
      // Make choices into string
      const stringChoices = this.choices.join();
      const convertedChoices = this.utils.toHex(stringChoices);
      // Convert data to bytes
      const convertedIssue = this.utils.toHex(this.issueText);

      // Construct arguments
      const sendArgs = [convertedIssue, convertedChoices];

      // Send
      this.drizzleInstance.contracts[this.contractName].methods[
        this.contractMethod
      ].cacheSend(...sendArgs);
    }
  }
};
</script>

<style>
.add-choice {
  display: flex;
  align-items: center;
  justify-content: center;
}
.add-choice button {
  padding: 11px 30px;
  font-weight: 600;
  background-color: cornflowerblue;
  color: white;
  outline: none;
  border: none;
  box-shadow: none;
  font-size: 1.2em;
}
.add-choice button:hover {
  cursor: pointer;
  background-color: darkslategray;
}
.add-choice input {
  padding: 10px 5px;
  outline: none;
  border: none;
  box-shadow: none;
  border-left: 1px solid grey;
  border-top: 1px solid grey;
  border-bottom: 1px solid grey;
  font-size: 1.2em;
}

ol,
li {
  list-style: none;
  font-size: 1.2em;
}
ol {
  padding: 0;
}

textarea {
  font-size: 1.2em;
  padding: 0.5rem;
}
.choices {
  display: flex;
  flex-direction: column;
  text-align: center;
  margin: 0 auto;
}

#submitIssue {
  padding: 11px 30px;
  font-weight: 600;
  background-color: cornflowerblue;
  color: white;
  outline: none;
  border: none;
  box-shadow: none;
  font-size: 1.2em;
}
#submitIssue:hover {
  cursor: pointer;
  background-color: darkslategray;
}
</style>
