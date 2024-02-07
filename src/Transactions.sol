// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";
/*
    Smart Contract para obtener registros de transacciones en la blockchain.
*/
contract transactions is Ownable(msg.sender){

    uint private transactionCount;

    // Estructura de registro de la transaccion en la Blockachain.
    struct Register{
        // Dirreccion de wallet que envia.
        address sender;
        // Direccion de wallet que recibe.
        address receiver;
        // Cantidad a enviar al receiver.
        uint amount;
        // Mensage a enviar
        string messager;
    }
    
    // Guardar en un array cada registro (Posible cambios).
    Register[] register;

    // Eventos de cada transaccion en la Blockchain.
    event Transaction(address indexed from,address indexed receiver,uint amount, string messager);


    // Funcion de hacer transaccion.
    function addRegistred(address _receiver, uint _amount, string memory _messager) public {
        transactionCount += 1;
        register.push(Register(msg.sender,_receiver,_amount,_messager));
        emit Transaction(msg.sender, _receiver, _amount, _messager);
    }

    function getRegister(uint8 _index) public view returns (Register memory){
        return register[_index];
    }

    // Funcion obtener todos los registros.
    function getRegistreAll() public view returns (Register[] memory) {
        return register;
    }

    function deleteArrayElement(uint8 _index) public onlyOwner {
         require(_index < register.length, "Invalid index"); 

         for (uint i = _index; i < register.length - 1; i++) {
          register[i] = register[i + 1];
         }
         register.pop();
    }


    // Funcion eliminar elementos de arrays(Todo).
    function deleteArrayElementAll() public onlyOwner{
        delete register;
    }

}
