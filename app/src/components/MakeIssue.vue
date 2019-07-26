<template>
  <section v-if="isDrizzleInitialized">
    <h1>What's Your Issue?</h1>
    <div class="issuehero">
      <div class="left">
        <textarea
          name="issueText"
          class="textarea is-large"
          cols="50"
          rows="3"
          placeholder="What color should the city paint the bike shed?"
          v-model="issueText"
        >
        </textarea>
        <div class="add-choice">
          <input
            class="input is-large"
            type="text"
            v-model="choiceInput"
            placeholder="Add choice..."
          />
          <button
            class="button is-white is-outlined is-large"
            @click="addChoice"
          >
            Add
          </button>
        </div>
        <button
          class="button is-white is-large is-outlined"
          id="submitIssue"
          @click.prevent="submitIssue"
        >
          Create Issue
        </button>
      </div>
      <div class="right">
        <span class="choiceBg">Choices</span>
        <div class="choices">
          <ol>
            <li v-for="(choice, index) in choices" :key="index">
              {{ choice }}
            </li>
          </ol>
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

      // Reset fields
      this.choiceInput = "";
      this.choices = [];
      this.issueText = "";
    }
  }
};
</script>

<style lang="scss" scoped>
section {
  padding: 30px 0px;
  margin: 0px;
  background-color: #6430cf;
}
h1 {
  font-size: 3em;
  font-weight: bold;
  padding: 1rem;
  color: #fff;
}
h2 {
  color: #fff;
}
.add-choice {
  padding: 20px 0px 0px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.right {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
}
.choiceBg {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translateX(-50%) translateY(-50%);
  font-size: 2.5em;
  color: rgba(100, 48, 150, 0.5);
  font-weight: bold;
}
input[type="text"] {
  margin-right: 1rem;
  padding-left: 0.7rem;
}

button {
  padding: 0px 20px;
}

#submitIssue {
  margin: 30px 0px 0px;
  width: 100%;
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
  padding: 0.7rem;
}
.choices {
  display: flex;
  flex-direction: column;
  text-align: center;
  margin: 0 auto;
  color: #fff;
}

.issuehero {
  display: grid;
  grid-template-columns: 1fr 1fr;
  padding: 20px 20px 60px;

  h2 {
    font-size: 1.5em;
    font-weight: bold;
    margin: 15px 0px;
  }
}
</style>
