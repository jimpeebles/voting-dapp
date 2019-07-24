pragma solidity >=0.4.21 <0.6.0;

contract Issues {
  uint issueCount = 0;

  event VoteCast(address voter, uint issueId, bytes32 choice);
  event IssueCreated(address creator, bytes32 issue, bytes32[] choices);

  struct Issue {
    bytes32 issueText;
    bytes32[] choices;
    mapping ( address => bytes32 ) votes;
  }

  mapping (uint => Issue) issues;

  function createIssue(bytes32 _issue, bytes32[] memory _choices) public {
    issues[issueCount] = Issue(_issue, _choices);
    issueCount++;
    emit IssueCreated(msg.sender, _issue, _choices);
  }

  function getIssueCount() public view returns (uint) {
    return issueCount;
  }

  function getIssue(uint _id) public view returns (bytes32 _issue, bytes32[] memory choices) {
    return (issues[_id].issueText, issues[_id].choices);
  }

  function castVote(bytes32 _choice, uint _issueId) public canVote(_issueId) {
    issues[_issueId].votes[msg.sender] = _choice;
    emit VoteCast(msg.sender, _issueId, _choice);
  }

  modifier canVote (uint _issueId) {
    require(issues[_issueId].votes[msg.sender] == 0, "You've already voted on this issue.");
    _;
  }
}
