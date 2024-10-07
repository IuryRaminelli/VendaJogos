<?php

/**
 * Arquivo que vai adicionar todos os produtos selecionados pelo cliente no carrinho;
 * Primeiramente é verificado se o cliente está logado;
 * Caso esteja, recuperamos o cpf do usuario logado, e armazenamos as infomações do produto selecionado no banco
 */

session_start();
include_once '../../DataBase/conexao.php';
include_once 'clienteControle.php';

$user = new clienteControle();
$result = $user->isLoggedIn();

if($result == true){
    $jogo = $_GET['jogo'];
    $conexao = new Conexao();
    $conexao = $conexao->conexao();
    $stmt = $conexao->prepare('SELECT idcarrinho FROM carrinho WHERE carrinho.cliente_cpf ="'.$_SESSION["user_cpf"].'";');
    $stmt->execute();
    $resultado = $stmt->fetch();
    $qts = 1;
    if($resultado == true){
        $stmt = $conexao->prepare("INSERT INTO carrinho_has_jogo(carrinho_idcarrinho, jogo_idjogo, quantidade) VALUES(:carrinho, :jogo, :quantidade);");
        $stmt->bindParam(':carrinho', $resultado[0]);
        $stmt->bindParam(':jogo', $jogo);
        $stmt->bindParam(':quantidade', $qts);
        $stmt->execute();
        $stmt = null;    
    }else{
        $stmt = $conexao->prepare("INSERT INTO carrinho(cliente_cpf) VALUES(:cpfCliente);");
        $stmt->bindParam(':cpfCliente', $_SESSION['user_cpf']);
        $stmt->execute();
        $carrinhoId = $conexao->lastInsertId();

        $stmt = $conexao->prepare("INSERT INTO carrinho_has_jogo(carrinho_idcarrinho, jogo_idjogo, quantidade) VALUES(:carrinho, :jogo, :equantidade);");
        $stmt->bindParam(':carrinho', $carrinhoId);
        $stmt->bindParam(':jogo', $jogo);
        $stmt->bindParam(':equantidade', $qts);
        $stmt->execute();
        $stmt = null;  
    }
    header('Location: ../../Venda/cart.php'); 
}else{
    header('Location: ../../Venda/login.php'); 
}


?>