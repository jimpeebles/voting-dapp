const Issues = artifacts.require("Issues");

module.exports = function(deployer) {
  deployer.deploy(Issues);
};
