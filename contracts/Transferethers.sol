//SPDX-License-Identifier:MIT

pragma solidity >=0.5.0 <0.9.0;

contract Transferethers{
    address public companyacc;

    event Transfer(address indexed sender,address indexed receiver,uint amount);



    constructor(address _company)
    {
        companyacc=_company;
    }

    function transfer() external payable returns(bool) 
    {
        //The account address transfers the ethers to the contract

        //The contract then transfers the same amount of ethers to the companyacc
        (bool sent,bytes memory data)=companyacc.call{value:msg.value}("");
        if(!sent)
        {
            return false;
        }

        emit Transfer(msg.sender,companyacc,msg.value);
        return true;
    }

    fallback() external payable{
        payable(msg.sender).transfer(msg.value);
    }
}