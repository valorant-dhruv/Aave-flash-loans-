//SPDX-License-Identifier:UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


//The Flashloans smart contract is inheriting the FlashLoanSimpleReceiverBase smart contract which is provided by AAVE
contract Flashloans is FlashLoanSimpleReceiverBase{

    //We are using the SafeMath library that is provided by openzeppelin
    using SafeMath for uint;
    event Log(address asset, uint val);

  //Now inside the constructor
  //We pass in the address of the pool provider
  //And this address is further passed up to the Aave smart contract which creates an instance of the POOL
  constructor(IPoolAddressesProvider provider)
    FlashLoanSimpleReceiverBase(provider)
  {}
  
  //This is the function that the user will call in order to generate a flash loan
  //It accepts two arguments the address of the smart contract of the token that the user wants
  //And second is the quantity of tokens that the user wants
  function createFlashLoan(address asset, uint amount) external {

      //The receiver of these tokens will be this smart contract only
      address receiver = address(this);
      bytes memory params = ""; // use this to pass arbitrary data to executeOperation
      uint16 referralCode = 0;

      //This calls the flashLoanSimple function of the POOL smart contract that we instantiated before
      //Hence once the function is called the tokens are transferred to this smart contract
      //and also the executeOperation function is called
      POOL.flashLoanSimple(
       receiver,
       asset,
       amount,
       params,
       referralCode
      );
  }

   function executeOperation(
    address asset,
    uint256 amount,
    uint256 premium,
    address initiator,
    bytes calldata params
  ) external returns (bool){
    // do things like arbitrage here
    // abi.decode(params) to decode params
    
    uint amountOwing = amount.add(premium);
    IERC20(asset).approve(address(POOL), amountOwing);
    emit Log(asset, amountOwing);
    return true;
  }
}