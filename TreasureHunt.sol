pragma solidity ^0.4.20;

contract TreasureHunt {
  bool active = false;
  bytes32 private solution = 0x41b1a0649752af1b28b3dc29a1556eee781e4a4c3a1f7f53f90fa834de098c4d;
  address public developer = 0xE5556c8F28245722222851b8E756adAd9E039E39;

  event TreasureHuntFunded(address funder, uint amount);

  function fund() public payable returns (bool) {
      require(msg.value > 0);
      TreasureHuntFunded(msg.sender, msg.value);
      return true;
  }

  function startHunt() public returns (bool) {
     require(msg.sender == developer);
     active = true;
     return true;
   }

  function validate(string _answer) public returns (bool) {
    if (active && keccak256(_answer) == solution) {
        msg.sender.transfer(this.balance);
        active = false;
        return true;
    }
    
    return false;
  }
}
