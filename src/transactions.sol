// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;

// Importar owner.

/*
    Smart Contract para obtener registros de transacciones en la blockchain.
*/
contract transactions {

    // Estructura de registro de la transaccion en la Blockachain.
    struct register{
        // Dirreccion de wallet que envia.
        address sender;
        // Direccion de wallet que recibe.
        address receiver;
        // Cantidad a enviar al receiver.
        uint amount;
        // Mensage a enviar
        string menssage;
        // (Posible registro de numero de bloques)
    }
    // Guardar en un array cada registro (Posible cambios).
    register[] registers;

    // Eventos de cada transaccion en la Blockchain.

    // Manejos de errores.

    // Funcion de hacer transaccion.

    // Funcion obtener todos los registros.

    // Funcion obtener registros por indices.

    // Funcion eliminar elementos de arrays(Todo).


}
