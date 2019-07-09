pragma solidity >=0.4.21 <0.6.0;

contract Issues {
  Issue[] public issues;
  Vote[] public votes;
  uint issueCount = 0;

  event VoteCast(address voter, uint issueId, string choice);
  event IssueCreated(address creator, string issue, bytes32[] choices);

  struct Issue {
    uint issueId;
    string issue;
    bytes32[] choices;
  }

  struct Vote {
    uint issueId;
    address voter;
    string choice;
  }

  function createIssue(string memory _issue, bytes32[] memory _choices) public {
    Issue memory issue = Issue(issueCount, _issue, _choices);
    issues.push(issue);
    issueCount++;
    emit IssueCreated(msg.sender, _issue, _choices);
  }

  function castVote(string memory _choice, uint _issueId) public {
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
