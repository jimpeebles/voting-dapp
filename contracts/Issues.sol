pragma solidity >=0.4.21 <0.6.0;

contract Issues {
  Issue[] public issues;
  Vote[] public votes;
  uint issueCount = 0;

  event VoteCast(address voter, uint issueId, bytes32 choice);
  event IssueCreated(address creator, bytes32 issue, bytes32[] choices);

  struct Issue {
    uint issueId;
    bytes32 issue;
    bytes32[] choices;
  }

  struct Vote {
    uint issueId;
    address voter;
    bytes32 choice;
  }

  function createIssue(bytes32 _issue, bytes32[] memory _choices) public {
    Issue memory issue = Issue(issueCount, _issue, _choices);
    issues.push(issue);
    issueCount++;
    emit IssueCreated(msg.sender, _issue, _choices);
  }

  function getIssueCount() public view returns (uint) {
    return issueCount;
  }

  function getIssue(uint _id) public view returns (bytes32 _issue, bytes32[] memory choices) {
    return (issues[_id].issue, issues[_id].choices);
  }

  function castVote(bytes32 _choice, uint _issueId) public {
    Vote memory vote = Vote(_issueId, msg.sender, _choice);
    votes.push(vote);
    emit VoteCast(msg.sender, _issueId, _choice);
  }

  function canVoteOnIssue(uint _issueId) public view returns (bool) {
    for (uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == msg.sender && votes[i].issueId == _issueId) {
                return false;
            }
        }
      return true;
  }
}
