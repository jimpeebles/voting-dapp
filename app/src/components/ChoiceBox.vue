<template>
  <div>
    <div class="choice">{{ value }}</div>
    <div class="tally">{{ key }}</div>
  </div>
</template>

<script>
export default {
  props: {
    choice: {
      type: String,
      required: true
    },
    issueId: {
      type: Number,
      required: true
    },
    tally: {
      type: Number,
      required: true
    }
  },
  methods: {
    vote() {
      this.$emit("vote", (this.choice, this.issueId));
    }
  }
};
</script>
