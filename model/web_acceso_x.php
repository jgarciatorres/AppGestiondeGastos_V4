<?php
class web_acceso_x{
    private $cn = null;

    public function __construct($conexion)
    {
        $this->cn = $conexion;
    }


    public function getAcceso($id_tipo_usuario, $url){
        $result = 0;

        $consulta = "SELECT IFNULL(COUNT(WEB.id_web_acceso), 0) AS 'acceso' FROM web_acceso AS WEB 
        LEFT JOIN web_url AS WEU ON WEB.id_web_url = WEU.id_web_url 
        WHERE WEB.id_tipo_usuario = $id_tipo_usuario AND WEU.web_url='$url'";
        
        
        $sql = $this->cn->query($consulta);
        if ($sql->num_rows > 0) {
            $acceso = $sql->fetch_assoc();
            $result = ($acceso == null  ? 0 : $acceso["acceso"]);
        }
        return $result;
    }
} 
?>