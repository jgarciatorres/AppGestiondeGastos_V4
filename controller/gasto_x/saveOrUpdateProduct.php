<?php
include("../shared/xheader.php");

$result = array(
    "estado" => "3",
    "mensaje" => "Ingresar los datos correctamente",
    //"post" => $_POST,
    //"file" => $_FILES,
);

if(isset($_POST)){


    require_once('../../model/gasto_x.php');
    require_once('../../component/database.php');
    require_once('../../component/util_functions.php');

    $pro_documento = 'pro_documento';
    $ruta_carpeta_imagen = "../../";

    $inconvenientes = "";
    $mi_conexion = new database();
    $mi_area=new gasto_x($mi_conexion->getCurrentConnection());

    $indicador = strval(isset($_POST["pro_producto"]) == true ? str_replace("pro_identity_","",$_POST["pro_producto"]) : 0);
    $usu_crea =  isset($_SESSION['session_admin']['id_usuario']) == true ? $_SESSION['session_admin']['id_usuario'] : 0;
    $id_presupuesto = isset($_POST['pro_presupuesto']) == true ? $_POST['pro_presupuesto'] : 0;
    $ruta_repo_img = util_functions::rutaPdfGastoX();

    $sin_presupuesto = isset($_POST['pro_sin_presupuesto']) == true ? $_POST['pro_sin_presupuesto'] : 0;
    $monto = $_POST["pro_monto"];

    $datos_presupuesto_gasto = null;
    $datos_monto_presupuestos = 0.0;
    $datos_monto_gastos = 0.0;
    $valor_porcentual = 0.0;

    $mensaje_uporInsert = "El presupuesto esta en un ";

    if($sin_presupuesto == 0){
        $datos_presupuesto_gasto = $mi_area->getPresupuestoMonto($id_presupuesto);

        if($datos_presupuesto_gasto != null){
            foreach ($datos_presupuesto_gasto as $fila) {
                if($fila["id_gasto"] == 0){
                    $datos_monto_presupuestos += $fila["monto"];
                }else{
                    if($indicador > 0) {
                        if($fila["id_gasto"] != $indicador){
                            $datos_monto_gastos += $fila["monto"];
                        }
                    }else{
                        $datos_monto_gastos += $fila["monto"];
                    }
                }
            }
        }

        $datos_monto_gastos += $monto;        
    }


    if($datos_monto_gastos > $datos_monto_presupuestos){

        $valor_porcentual = (($datos_monto_gastos * 100.0) / $datos_monto_presupuestos) - 100;

        
        //result aqui

        $result = array(
            "estado" => "4",
            "mensaje" =>  "El monto ingresado sobrepasa al presupuesto en un ".number_format($valor_porcentual,2)."%",
            "monto_prespuestos" => $datos_monto_presupuestos,
            "monto_gastos" => $datos_monto_gastos,
            "mensa2" => $mensaje_uporInsert,
        );

    }else{
    
        $valor_porcentual  = (($datos_monto_gastos * 100.0) / $datos_monto_presupuestos);

        $mensaje_uporInsert.= number_format($valor_porcentual,2)."%";

        if($indicador > 0){
            $id_gasto = $indicador;
            $motivo = $_POST["pro_motivo"];
            $ruc = $_POST["pro_ruc"];
            $nro_documento = $_POST["pro_nro_documento"];
            $razon_social = $_POST["pro_razon_social"];
            $fecha = $_POST["pro_fecha"];


            if(isset($_FILES['pro_documento']['name']) && $_FILES['pro_documento']['name'] != ""){

                $nombre_archivo=$_FILES[$pro_documento]['name'];
                $tamanio_archivo=$_FILES[$pro_documento]['size'];
                $ruta_imagen=$_FILES[$pro_documento]['tmp_name'];
                $extension_archivo = pathinfo($nombre_archivo, PATHINFO_EXTENSION);
            

                if(util_functions::existeLaImagen($ruta_carpeta_imagen.$ruta_repo_img.$nuevo_nombre_archivo.".pdf")){
                    $nuevo_nombre_archivo = $nuevo_nombre_archivo."_2";
                }
        
                if(!copy($ruta_imagen,$ruta_carpeta_imagen.$ruta_repo_img.$nuevo_nombre_archivo.".pdf")) {
                    $inconvenientes.= "Error al copiar el documento. ".$sku;
                }else{
                    $resultado =  $mi_area->editarGasto($id_gasto,$id_presupuesto,$sin_presupuesto,$motivo, $ruc, 
                        $nro_documento,$razon_social, $monto, $fecha, $ruta_documento, $usu_crea);
            
                    $result = array(
                        "estado" => "1",
                        "mensaje" =>  ($resultado == true ? "Se actualizo con exito, ".$mensaje_uporInsert : "Error al actualizar"),
                    );
                }
            }else{
                $resultado =  $mi_area->editarGastoSinDoc($id_gasto,$id_presupuesto,$sin_presupuesto,$motivo, $ruc, 
                $nro_documento,$razon_social, $monto, $fecha, $usu_crea);
        
                $result = array(
                    "estado" => "1",
                    "mensaje" =>  ($resultado == true ? "Se actualizo con exito, ".$mensaje_uporInsert : "Error al actualizar"),
                );
            }

            if($inconvenientes != ""){
                $result = array(
                    "estado" => "3",
                    "mensaje" =>  $inconvenientes,
                );
            }

        }else if($indicador == 0){

            $motivo = $_POST["pro_motivo"];
            $ruc = $_POST["pro_ruc"];
            $nro_documento = $_POST["pro_nro_documento"];
            $razon_social = $_POST["pro_razon_social"];
            $fecha = $_POST["pro_fecha"];

            if(isset($_FILES['pro_documento'])){

                $nombre_archivo=$_FILES[$pro_documento]['name'];
                $tamanio_archivo=$_FILES[$pro_documento]['size'];
                $ruta_imagen=$_FILES[$pro_documento]['tmp_name'];
                $extension_archivo = pathinfo($nombre_archivo, PATHINFO_EXTENSION);
            

                if(util_functions::extensionPdfPermitidaX($extension_archivo) 
                && util_functions::tamanioPdfPermitidaX($tamanio_archivo)){
            
                    $nuevo_nombre_archivo=util_functions::generateNamePdfX();

                    if(util_functions::existeLaImagen($ruta_carpeta_imagen.$ruta_repo_img.$nuevo_nombre_archivo.".pdf")){
                        $nuevo_nombre_archivo = $nuevo_nombre_archivo."_2";
                    }
            
                    if(!copy($ruta_imagen,$ruta_carpeta_imagen.$ruta_repo_img.$nuevo_nombre_archivo.".pdf")) {
                        $inconvenientes.= "Error al copiar el documento. ".$sku;
                    }else{
            
                        $ruta_documento = $nuevo_nombre_archivo.".pdf";
            
                        $resultado = $mi_area->guardarGasto($id_presupuesto, $sin_presupuesto,$motivo, $ruc, $nro_documento, 
                        $razon_social, $monto, $fecha, $ruta_documento, $usu_crea);
            
                        $result = array(
                            "estado" => "1",
                            "mensaje" =>  ($resultado == true ? "Se guardo con exito, ".$mensaje_uporInsert : "Error al guardar"),
                        );
                    }
                }else{
                    $inconvenientes.= "Extension o tamanio del documento no permitida. ";
                }
            }else{
                $inconvenientes.= "No existe el documento ingresado";
            }

            if($inconvenientes != ""){
                $result = array(
                    "estado" => "3",
                    "mensaje" =>  $inconvenientes,
                );
            }
        }else{
            $result = array(
                "estado" => "3",
                "mensaje" =>  "Manipulacion del DOM. ",
            );
        }
    }

    
   
    echo json_encode($result);
}else{
    echo json_encode($result);
}
?>