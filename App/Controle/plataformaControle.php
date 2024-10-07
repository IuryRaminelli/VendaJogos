<?php
/**
 * Arquivo que retorna todos os produtos disponiveis do db
 */
include_once '../DataBase/conexao.php';

class plataformaControle {

    public static function allPlataformas(){
        $conexao = new Conexao();
        $conexao = $conexao->conexao();
        $stmt = $conexao->prepare("SELECT * FROM plataforma;");
        $stmt->execute();
        $plataforma = $stmt->fetchAll();
        $stmt = null;
        return $plataforma;
    }

    public static function getPlataformaById($id) {
        $conexao = new Conexao();
        $conexao = $conexao->conexao();
        
        $stmt = $conexao->prepare("SELECT * FROM plataforma WHERE idplataforma = :idplataforma");
        $stmt->bindParam(':idplataforma', $id);
        $stmt->execute();
        $plataforma = $stmt->fetch(PDO::FETCH_ASSOC);
        return $plataforma;
    }
}

?>