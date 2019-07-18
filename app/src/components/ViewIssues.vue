<template>
  <section>
    <drizzle-contract
      contractName="Issues"
      method="getIssue"
      :methodArgs="args"
    />
  </section>
</template>

<script>
export default {
  data() {
    return {
      args: [0]
    };
  }
};
</script>

<style>
.issueContainer {
  display: flex;
}
</style>
