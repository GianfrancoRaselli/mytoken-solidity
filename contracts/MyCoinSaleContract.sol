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

  function mul(uint256 a, uint256 b) internal pure returns (uint256 result) {
    if (a == b) {
      return 0;
    }
    uint256 c = a * b;
    require(c / a == b);
    return c;
  }

  function buy(uint256 _numTokens) public payable {
    require(msg.value == mul(price, _numTokens));
    uint256 scaledAmount = mul(_numTokens, uint256(10) ** myCoinInterface.decimals());
    require(myCoinInterface.balanceOf(address(this)) >= scaledAmount);
    tokensSold += _numTokens;
    require(myCoinInterface.transfer(msg.sender, scaledAmount));
    emit Sold(msg.sender, _numTokens);
  }

  function endSold() public {
    require(msg.sender == owner);
    require(myCoinInterface.transfer(owner, myCoinInterface.balanceOf(address(this))));
    payable(owner).transfer(address(this).balance);
  }

}