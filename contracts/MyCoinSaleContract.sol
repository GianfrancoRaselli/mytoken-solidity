// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

interface MyCoinInterface {
  function decimals() external view returns(uint8);
  function balanceOf(address _address) external view returns(uint256);
  function transfer(address _to, uint256 _value) external returns(bool success);
}

contract MyCoinSaleContract {

  address owner;
  uint256 price;
  MyCoinInterface myCoinInterface;
  uint256 tokensSold;

  event Sold(address buyer, uint256 amount);

  constructor(uint256 _price, address _addressContract) {
    owner = msg.sender;
    price = _price;
    myCoinInterface = MyCoinInterface(_addressContract);
  }

}