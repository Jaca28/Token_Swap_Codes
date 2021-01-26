// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.8.0;

/** 
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */
contract usd_demo {
    address private owner;
    uint sold_eth;
    constructor() {
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
    }
    
    mapping (address => uint) address2usd_balance;
    function buy_usd(uint price_eth_usd) external payable returns (uint saldo_final,uint  cantidad_comprada){
        require(price_eth_usd>=0);
        address2usd_balance[msg.sender]=address2usd_balance[msg.sender]+price_eth_usd/(msg.value*1000000000000000000);
        return (address2usd_balance[msg.sender],price_eth_usd*msg.value);
    }
    function sell_usd(uint price_eth_usd, uint sell_usd) public payable{
        require(address2usd_balance[msg.sender]>=sell_usd,"no tienes suficiente usd");
        sold_eth=price_eth_usd*sell_usd;
        require(address(this).balance>=sold_eth, "el contrato no tiene suficiente ether para hacer el intercambio");
        msg.sender.transfer(sold_eth);
    }
    function show_usd_balance() public view returns (uint){
        return (address2usd_balance[msg.sender]);
    }
    function show_contract_eth_balance() public view returns (uint){
        return (address(this).balance);
    }
}