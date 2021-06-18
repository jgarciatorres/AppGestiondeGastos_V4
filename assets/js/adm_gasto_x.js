const M_PDF_RUTA_P01 = `../assets/upload/gasto/`;

function miOpenAndClosedContent(objeto){
    var closeado = document.getElementById(objeto).style;
    if(closeado.display === 'none'){
      closeado.display = 'block';
    }else{
      closeado.display = 'none';
    }
}

function getProductsList(desde = 0, hasta = 100){
    let tabla_body = document.getElementById("tbody_cargar");
    $.ajax({
        type: "POST",
        url: "../controller/gasto_x/getPresupuestoList.php",
        data: {desde: desde, hasta: hasta},
        beforeSend: function () {
            miOpenAndClosedContent("my_capa_negra_tabla");
        },
        success: function (info) {
            console.log(info);
            tabla_body.innerHTML = ``;
            let mi_json = JSON.parse(info);
            if(mi_json.estado == 1 ){
                window.ns_contador.paginacion(mi_json.paginacion);
                mi_json.lista.forEach(mi_sku => {
                    tabla_body.innerHTML += `
                    <tr id="pro_identity_` + mi_sku.id_gasto + `"  ` + ( mi_sku.estado == 1 ? ` style="color:gray;" ` : ``) + `  >
                    
                        <td class="mi_celda_boton p-1">
                            <button type="button" class="btn btn-sm btn-theme-plane" title="Editar" onclick="onProductEditable(this)" ><i class="fas fa-pencil-alt"></i></button>
                            <button type="button" class="btn btn-sm btn-` + ( mi_sku.estado == 1 ? `success` : `danger`) + `" 
                                title="` + ( mi_sku.estado == 1 ? `Activado` : `Desactivado`) + `" onclick="onProductDelete(this,` + (mi_sku.estado == 1 ? 0 : 1) + `)" >
                                ` + ( mi_sku.estado == 1 ? `A` : `D`) + `</button>
                        </td>
                        <td class="p-1 ">` + (mi_sku.presupuesto == null ? `-` : mi_sku.presupuesto) + `</td>
                        <td class="p-1 " >` + (mi_sku.sin_presupuesto == 1 ? `Si` : `No`) + `</td>
                        <td class="p-1 texto_sobrecargado" ><div class="mi_contenedor">` + mi_sku.motivo + `</div></td>
                       
                        <td class="p-1 ">` + (mi_sku.ruc == null ? `Sin ruc` : mi_sku.ruc) + `</td>
                        <td class="p-1 ">` + (mi_sku.nro_documento == null ? `Sin nº de documento` : mi_sku.nro_documento) + `</td>
                        <td class="p-1 ">` + (mi_sku.razon_social == null ? `Sin razón social` : mi_sku.razon_social) + `</td>
                        <td class="p-1 ">` + (mi_sku.monto == null ? `Sin monto` : mi_sku.monto) + `</td>
                        <td class="p-1 ">` + (mi_sku.fecha == null ? `Sin fecha` : mi_sku.fecha) + `</td>

                        <td class="p-1 " >` + (mi_sku.ruta_documento == null ? `Sin documento` : `<a href="`+ M_PDF_RUTA_P01 + mi_sku.ruta_documento +`" target="_blank" >Ver documento</a>` ) + `</td>
                    </tr>`;
                
                });
                $('.table-responsive').doubleScroll({
                    resetOnWindowResize: true
                });
            }else if(mi_json.estado == 2 ){
                tabla_body.innerHTML = ``;
            }
            miOpenAndClosedContent("my_capa_negra_tabla");
        },
        error: function () {
            console.log("Error");
        }
    });
}

document.getElementById("btn_producto_nuevo").onclick = function(event){
    //let objeto = event.target;
    $("#btn_producto_nuevo").attr("disabled", true);
    $("#btn_producto_guardar").attr("disabled", false);
    $("#btn_producto_cancelar").attr("disabled", false);
};

document.getElementById("btn_producto_cancelar").onclick = function(){
    $("#btn_producto_nuevo").attr("disabled", false);
    $("#btn_producto_guardar").attr("disabled", true);
    $("#btn_producto_cancelar").attr("disabled", true);

    onResetFormulario();
};

document.getElementById("mi_btn_anterior").onclick = function(){
    window.ns_contador.anterior(); 
};

document.getElementById("mi_btn_siguiente").onclick = function(){
    window.ns_contador.siguiente(); 
};

function seleccionarComboPorTexto(id, texto){
    var eid = document.getElementById(id);
    var devolucion = false;
    for (var i = 0; i < eid.options.length; ++i) {
        if(eid.options[i].text === texto){
          eid.options[i].selected = true;
          devolucion = true;
          break;
        }
    }
    return devolucion;
}

function seleccionarComboPorTextoNuevo(id, texto){
    var eid = document.getElementById(id);
    var devolucion = false;
    for (var i = 0; i < eid.options.length; ++i) {
        //console.log(eid.options[i].text + "-" + texto + "-" + eid.options[i].text.indexOf(texto));
        if(eid.options[i].text.indexOf(texto) > -1){
          eid.options[i].selected = true;
          devolucion = true;
          break;
        }
    }
    return devolucion;
}

function filterFloat_x(evt,input){
    // Backspace = 8, Enter = 13, ‘0′ = 48, ‘9′ = 57, ‘.’ = 46, ‘-’ = 43
    var key = window.Event ? evt.which : evt.keyCode;    
    var chark = String.fromCharCode(key);
    var tempValue = input.value+chark;
    if(key >= 48 && key <= 57){
        if(filter_x(tempValue)=== false){
            return false;
        }else{       
            return true;
        }
    }else{
          if(key == 8 || key == 13 || key == 46 || key == 0) {            
              return true;              
          }else{
              return false;
          }
    }
}

function filter_x(__val__){
    var preg = /^([0-9]+\.?[0-9]{0,2})$/; 
    if(preg.test(__val__) === true){
        return true;
    }else{
       return false;
    }
    
}

function validacionEspecial(e){
    var tecla = (document.all) ? e.keyCode : e.which;
    tecla = String.fromCharCode(tecla)
    return /^\d|\-|\*|\/$/.test(tecla);
}
  
function validacionNumero(e){
    var tecla = (document.all) ? e.keyCode : e.which;
    tecla = String.fromCharCode(tecla)
    return /^\d$/.test(tecla);
}

function validacionLetra(e){
    var tecla = (document.all) ? e.keyCode : e.which;
    tecla = String.fromCharCode(tecla)
    return /^[a-zA-ZÀ-ÿ\u00f1\u00d1\s]$/.test(tecla);
}

function valDecimal_x(e, field){
    key = e.keyCode ? e.keyCode : e.which
    // backspace
    if (key == 8) return true
    // 0-9
    if (key > 47 && key < 58) {
        if (field.value == "") return true
        regexp = /.[0-9]{10}$/
        return !(regexp.test(field.value))
    }
    // .
    if (key == 46) {
        if (field.value == "") return false
        regexp = /^[0-9]+$/
        return regexp.test(field.value)
    }
    // other key
    return false
}

function onProductDelete(objeto, value){
    let mensaje_modal = "";
    if(value==1){
        mensaje_modal ="¿Deseas activar el gasto?";
    }else{
        mensaje_modal ="¿Deseas desactivar el gasto?";
    }

    alertify.confirm(mensaje_modal, function (param1) {
        console.log("si");
        let entidad = $(objeto).parent().parent().attr('id');
        $.ajax({
            type: "POST",
            url: "../controller/gasto_x/desactivarProducto.php",
            data: { entidad: entidad, valor: value},
            beforeSend: function () {
            },
            success: function (info) {
                let mi_json = JSON.parse(info);
                if (mi_json.estado == "1"){
                    alertify.success(mi_json.mensaje);
                }else{
                    alertify.error(mi_json.mensaje);
                }
            },
            error: function () {
                alertify.error('Error');
            }
        });
    },function(param2){
        console.log("no");
    }).set({title:"Producto"}).set({labels:{ok:'SI', cancel: 'NO'}});
}

function onProductEditable(objeto){
    let registro = $(objeto).parent().parent();
    let entidad = $(registro).attr('id');
    let fila = $(registro).find("td");

    $("#pro_producto").val(entidad);

    let sumar_columna = 1;

    seleccionarComboPorTexto("pro_presupuesto",$(fila[0 + sumar_columna]).text());
    $("#pro_presupuesto").selectpicker("refresh");
    $('#pro_presupuesto').trigger('change');

    seleccionarComboPorTexto("pro_sin_presupuesto",$(fila[1 + sumar_columna]).text());

    if($(fila[1 + sumar_columna]).text()== "Si"){
        $('#pro_motivo').prop("required", true);
        $('#pro_motivo').prop("readonly", false);
    }else{
        $('#pro_motivo').prop("required", false);
        $('#pro_motivo').prop("readonly", true);
    }

    $("#pro_motivo").val($(fila[2 + sumar_columna]).text());

    $("#pro_ruc").val($(fila[3 + sumar_columna]).text());
    $("#pro_nro_documento").val($(fila[4 + sumar_columna]).text());
    $("#pro_razon_social").val($(fila[5 + sumar_columna]).text());

    $("#pro_monto").val($(fila[6 + sumar_columna]).text());
    $("#pro_fecha").val($(fila[7 + sumar_columna]).text());


    let m_documento = $(fila[8 + sumar_columna]).find('a').attr('href');

    if(m_documento == undefined){
        $('#pro_documento').prop("required", true);
    }else{
        $('#pro_documento').prop("required", false);
    }

    $("#btn_producto_nuevo").attr("disabled", true);
    $("#btn_producto_guardar").attr("disabled", false);
    $("#btn_producto_cancelar").attr("disabled", false);

    $('#collapseOne').collapse();
    $('#pro_presupuesto').focus();
    alertify.success('Registro listo para editar.');
}

function onResetFormulario(){

    console.log("aqui reset");

    $("#pro_producto").val("0");

    $('#pro_presupuesto').val("0");
    $("#pro_presupuesto").selectpicker("refresh");
    $('#pro_presupuesto').trigger('change');

    $("#pro_sin_presupuesto").val("0");
    
    $('#pro_motivo').val("");
    $('#pro_motivo').prop("required", false);
    $('#pro_motivo').prop("readonly", true);

    $("#pro_ruc").val("");
    $("#pro_nro_documento").val("");
    $("#pro_razon_social").val("");

    $("#pro_fecha").val("null");
    $("#pro_monto").val("");

    $('#pro_documento').prop("required", true);
    
    $("#btn_producto_nuevo").attr("disabled", false);
    $("#btn_producto_guardar").attr("disabled", true);
    $("#btn_producto_cancelar").attr("disabled", true);
}

$("#producto_gruardar").submit(function (event) {
    event.preventDefault();
    let parametros = new FormData(this);
    saverOrUpdateProduct(parametros);
});

function saverOrUpdateProduct(parametros){
    //console.log(parametros);

    $.ajax({
        type: "POST",
        url: "../controller/gasto_x/saveOrUpdateProduct.php",
        enctype: 'multipart/form-data',
        contentType: false,
        processData: false,
        data: parametros,
        beforeSend: function () {
        },
        success: function (info) {
            console.log(info);
            let mi_json = JSON.parse(info);
            if (mi_json.estado == "1"){
                onResetFormulario();
                alertify.success(mi_json.mensaje);
            }else{
                alertify.success(mi_json.mensaje);
            }
        },
        error: function () {
            console.log("Error");
        }
    });
}

function selectFactoryList(componente = "", url = "", paramametro = 100){
    let mi_select = document.getElementById(componente);
    $.ajax({
        type: "POST",
        url: "../controller/" + url,
        data: {numero:paramametro},
        beforeSend: function () {
        },
        success: function (info) {
            console.log(info);
            mi_select.innerHTML = `<option value="0" selected disabled>-- Seleccione --</option>`; 
            let mi_json = JSON.parse(info);
            if(mi_json.estado == 1 ){
                mi_json.lista.forEach(mi_dato_select => {
                    mi_select.innerHTML += `<option value="`+mi_dato_select.id+`">`+mi_dato_select.nombre+`</option>`;
                });
                $(mi_select).selectpicker("refresh");
            }
        },
        error: function () {
            console.log("Error");
        }
    });
}

function cargarGeneral(){

    $("#pro_sin_presupuesto").change(function(event){
        //let mi_estado = $(this).is(':selected');
        let mi_estado = $(this).val();
        //console.log(mi_estado);

        if(mi_estado == 1){
            $('#pro_motivo').prop("required", true);
            $('#pro_motivo').prop("readonly", false);
        }else{
            $('#pro_motivo').prop("required", false);
            $('#pro_motivo').prop("readonly", true);
        }
    });
    
    selectFactoryList("pro_presupuesto", "gasto_x/getListSelectPresu.php");
}

$(document).ready(function () {
    window.ns_contador = {
        mostrado: 1,
        desde: 0,
        hasta: 1,
        total: 1,
        pagina_actual: 1,
        pagina_total: 1,
        primera_vez: 0,
        primer_siguiente:  0,
        paginacion: function(mi_paginacion){
            if (this.primera_vez == 0){
                this.mostrado = mi_paginacion.mostrado;
                this.total = mi_paginacion.total;
                this.pagina_actual = mi_paginacion.pagina_actual;
                this.hasta = mi_paginacion.mostrado;
                this.pagina_total = mi_paginacion.pagina_total;
                this.primera_vez = 1;
                this.mi_pagina_actual();
                console.log("E Primera");
                this.valores();
            }else{
                this.pagina_total = mi_paginacion.pagina_total;
            }
        },
        siguiente: function(){
            if(this.pagina_total > this.pagina_actual){
                this.pagina_actual += 1; 
                this.desde += (this.mostrado);
                this.hasta += ( this.mostrado); 
                this.valores();
                getProductsList(this.desde, this.hasta);
                this.mi_pagina_actual();
            }
        },
        anterior: function(){
            if(this.pagina_actual  > 1){
                this.pagina_actual -= 1; 
                this.desde -= (this.mostrado );
                this.hasta -= ( this.mostrado ); 
                this.valores();
                getProductsList(this.desde, this.hasta);
                this.mi_pagina_actual();
            }
        },
        mi_pagina_actual: function(){
            document.getElementById("mi_pagina_actual").innerText = this.pagina_actual + " / " + this.pagina_total;
        },
        valores: function(){
            console.log("de: " + this.mostrado);
            console.log("desde: " + this.desde);
            console.log("hasta: " + this.hasta);
            console.log("total: " +this.total);
            console.log("pag. actual: " + this.pagina_actual);
            console.log("pag. total: " + this.pagina_total);
        }
    }
    cargarGeneral();
    getProductsList();
});