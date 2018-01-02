pragma solidity ^0.4.0;
import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";

contract USDPrice is usingOraclize {

    uint public price;

    event Log(string text);

    function USDPrice() {
        Log("Contract created.");
        update();
    }

    function getPrice() constant returns (uint) {
        return price;
    }

    function __callback(bytes32 _myid, string _result) {
        require (msg.sender == oraclize_cbAddress());
        Log(_result);
        price = parseInt(_result, 2); // let's save it as $ cents
    }

    function update() payable {
        Log("Oraclize query was sent, waiting for the answer..");
        oraclize_query("URL","json(https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD).USD");
    }

}