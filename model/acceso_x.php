<?php
class acceso_x{

    private $tipo_usuario = null;

    /*
    1. admin = todo
    2. supervisor =  prespuestos y gastos
    3. colaborador = solo reg gastos
    */

    public function __construct(){ 
        $this->tipo_usuario = isset($_SESSION['session_admin']['id_tipo']) == true ? $_SESSION['session_admin']['id_tipo'] : 0;
    }

    public function getPermisoArea(){
        if($this->tipo_usuario == 1 && $this->tipo_usuario > 0){
            return 1;
        }else{
            return 0;
        }
    }

    public function getPermisoUsuario(){
        if($this->tipo_usuario == 1 && $this->tipo_usuario > 0){
            return 1;
        }else{
            return 0;
        }
    }

    public function getPermisoRegPresu(){
        if(($this->tipo_usuario ==  2 || $this->tipo_usuario == 1) && $this->tipo_usuario > 0){
            return 1;
        }else{
            return 0;
        }
    }

    public function getPermisoAsigPresu(){
        if(($this->tipo_usuario == 2 || $this->tipo_usuario == 1) && $this->tipo_usuario > 0){
            return 1;
        }else{
            return 0;
        }
    }

    public function getPermisoRegGasto(){
        if(($this->tipo_usuario ==  3 || $this->tipo_usuario ==  2 || $this->tipo_usuario == 1) && $this->tipo_usuario > 0){
            return 1;
        }else{
            return 0;
        }
    }
    
    public function getPermisoBusGasto(){
        if( ($this->tipo_usuario == 2 || $this->tipo_usuario == 1) && $this->tipo_usuario > 0){
            return 1;
        }else{
            return 0;
        }
    }
}
