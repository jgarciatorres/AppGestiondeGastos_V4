<?php

require_once('../component/database.php');
require_once("../model/web_acceso_x.php");

class seguridad{
    private static $is_security = 0;
    //0 --> ACTIVADA
    //1 --> DESACTIVADA
    public static function callSeguridad(){

        $miHost = $_SERVER['HTTP_HOST'];
        $miUrl = $_SERVER['REQUEST_URI'];

        $miTipoUsuario =  isset($_SESSION['session_admin']['id_tipo']) == true ? $_SESSION['session_admin']['id_tipo'] : 0;
        
        //var_dump($_SESSION['session_admin']);

        if(self::$is_security == 0){
            if(empty($_SESSION)){
                echo "<script>
                        window.location.href ='http://".$miHost."';
                    </script>";
                exit();
            }else{

                $mi_conexion = new database();
                $acceso = new web_acceso_x($mi_conexion->getCurrentConnection());

                $miPosicion = stripos($miUrl, "/presu");
                $miUrl = substr($miUrl, $miPosicion, strlen($miUrl));
                $miUrl = str_replace("/presu", "", $miUrl);
                $valor = $acceso->getAcceso($miTipoUsuario, $miUrl);

                if($valor == 0){
                    header("Location: ../ ");
                    exit();
                }
                //echo "<script> alert('".$valor."-".$miTipoUsuario."-".$miUrl."'); </script>";
            }
        }else{
            header("Location: ./ ");
            exit();
        }
    }
}
?>