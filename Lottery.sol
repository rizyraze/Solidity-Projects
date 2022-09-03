• Participant must have a wallet. 
• A participant can transfer ether more than one time but the transferred ether must be 2
ether.
• As the participant will transfer ether its address will be registered. 
• Manager will have full control over the lottery. 
• The contract will be reset once a round is completed.


//SPDX -Licence-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;
contract Lottery{
    address public manager;
    address payable[] public participants;

    constructor(){
        manager = msg.sender;
    }

    receive() external payable{
        require(msg.value == 1 ether);
        participants.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint){
        require(msg.sender == manager);
        return address(this).balance;
    }

    function random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));
    }

    function selectWinner() public { 
        require(msg.sender == manager);
        require(participants.length>=3);
        uint r = random();
        uint index = r%participants.length;
        address payable winner;
        winner = participants[index];
        winner.transfer(getBalance());

        participants= new address payable[](0)
    }
}
