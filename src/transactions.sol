// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;

import "/";

/*
    Smart Contract para obtener registros de transacciones en la blockchain.
*/
contract transactions is Ownable{

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
        // (Posible registro de numero de bloques)
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

    // Funcion obtener todos los registros.
    function getRegistreALl() view public returns (Register[] memory) {
        return register;
    }

    // Funcion eliminar elementos de arrays(Todo).
    function deleteArryElement() public onlyOwner{
        delete register;
    }

}
