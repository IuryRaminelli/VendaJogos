<?php
session_start();
include_once '../../DataBase/conexao.php';
include_once 'clienteControle.php';

$user = new clienteControle();

    $conexao = new Conexao();
    $conexao = $conexao->conexao();

    $stmt = $conexao->prepare('UPDATE carrinho_has_jogo SET quantidade = :quantidade WHERE jogo_idjogo = :idjogo ');
    $stmt->execute( array(
                    ':quantidade' => $_POST['id_quantidade'],
                    ':idjogo' => $_POST['idjogo']
                    )
                );
    $stmt = null;  


header('Location: ../../Venda/cart.php'); 

?>