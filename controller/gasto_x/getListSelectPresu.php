<?php
include("../shared/xheader.php");
$result = array(
    "estado" => "3",
    "mensaje" => "Ingresar parametros",
    "lista" => null,
);

if(isset($_POST['numero']) ){
    $numero=$_POST['numero'];
	if(is_numeric($numero)){
        require_once('../../model/presupuesto_x.php');
        require_once('../../component/database.php');

        $usu_crea =  isset($_SESSION['session_admin']['id_usuario']) == true ? $_SESSION['session_admin']['id_usuario'] : 0;
        $usu_area =  isset($_SESSION['session_admin']['id_area']) == true ? $_SESSION['session_admin']['id_area'] : 0;

        $mi_conexion = new database();
        $mi_clase = new presupuesto_x($mi_conexion->getCurrentConnection());
        $cantidad = 20;
        $mi_data = $mi_clase->getListSelectByUserOrArea($usu_crea,$usu_area);
        
		if(count($mi_data) > 0 ){
            echo json_encode($mi_data);
        }else{
            $result = array(
                "estado" => "3",
                "mensaje" => "Error al buscar",
                "lista" => null,
            );
            echo json_encode($result);
        }
    }else{
        $result = array(
            "estado" => "3",
            "mensaje" => "Los parametros no son numericos",
            "lista" => null,
        );
        echo json_encode($result);
    }
}else{
    echo json_encode($result);
}
?>