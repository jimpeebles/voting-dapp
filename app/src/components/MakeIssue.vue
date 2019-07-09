<template>
  <section>
    <h2>Create An Issue</h2>
    <textarea
      name="issueText"
      cols="50"
      rows="10"
      placeholder="What color should the city paint the bike shed?"
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
  </section>
</template>

<script>
export default {
  data() {
    return {
      choiceInput: "",
      choices: []
    };
  },
  methods: {
    addChoice() {
      this.choices.push(this.choiceInput);
      this.choiceInput = "";
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
}
.choices {
  display: inline-flex;
  flex-direction: column;
  text-align: left;
  margin: 0 auto;
}
</style>
