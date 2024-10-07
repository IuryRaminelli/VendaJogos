<?php

	session_start();
	include_once '../../DataBase/conexao.php';
	include_once 'clienteControle.php';

	$user = new clienteControle();

    $conexao = new Conexao();
    $conexao = $conexao->conexao();

    $stmt = $conexao->prepare('DELETE FROM carrinho_has_jogo WHERE jogo_idjogo = :idjogo ');
    $stmt->execute( array(
                    ':idjogo' => $_GET['jogo']
                    )
                );
    $stmt = null;  


header('Location: ../../Venda/cart.php'); 

?>