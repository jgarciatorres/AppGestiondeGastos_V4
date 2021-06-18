<?php
class admin_x{

    private $cn = null;

    public function __construct($conexion){ $this->cn = $conexion; }

    public function getLogin($usuario, $clave){

        $consulta = "SELECT id_usuario, id_tipo, id_area FROM usuario WHERE usuario = '$usuario' AND clave = '$clave' AND estado=1 LIMIT 1";

        try {
            $sql = $this->cn->query($consulta);
            if ($sql) {
                if ($sql->num_rows > 0) {
                    return $sql->fetch_assoc();
                } else {
                    return 0;
                }
            } else {
                return -1;
            }
        } catch (Exception $e) {
            return -1;
        }
    }
}
