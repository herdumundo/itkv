<%-- 
   Document   : contenedor_registro_reprocesos
   Created on : 15-dic-2021, 9:51:44
   Author     : hvelazquez
--%>
 <%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.jfree.data.general.Dataset"%>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 

<%    PreparedStatement ps, ps2, ps3, ps4, ps5, ps6,ps7;
    ResultSet rs, rs2, rs3, rsActividad,  rsRubro, rs6,rsBalanceado;
    String fecha="";
    try {
        ps = connection.prepareStatement(" SELECT DISTINCT T0.[U_retiradopor] as U_retiradopor              FROM    IGE1 T0");// 3
        rs = ps.executeQuery();
 
        ps3 = connection.prepareStatement(" SELECT T0.[PrcCode], T0.[PrcName], T0.[U_CodAnt], T0.[U_Comen]  FROM    OPRC T0 WHERE T0.[DimCode] = 3 ");// UBICACION
        rs3 = ps3.executeQuery();

        ps4 = connection.prepareStatement(" SELECT T0.[PrcCode], T0.[PrcName], T0.[U_CodAnt], T0.[U_Comen]  FROM    OPRC T0 WHERE T0.[DimCode] = 2 	 AND [PrcName] LIKE '%HACIENDA%' ");// RUBRO
        rsActividad = ps4.executeQuery();

        ps5 = connection.prepareStatement(" SELECT T0.[PrcCode], T0.[PrcName], T0.[U_CodAnt], T0.[U_Comen]  FROM    OPRC T0 WHERE T0.[DimCode] =  1");// ACTIVIDAD
        rsRubro = ps5.executeQuery();
    

        ps7 = connection.prepareStatement("SELECT ItemCode , ItemName  , ItmsGrpCod 	 , OnHand , InvntryUom     FROM   oitm	where      QryGroup1='Y' ");// ACTIVIDAD
        rsBalanceado = ps7.executeQuery();
        
        ps2 = connection.prepareStatement("SELECT  convert(varchar,getdate(),103) as fecha  ");// ACTIVIDAD
        rs2 = ps2.executeQuery();
        
        while(rs2.next()){
            fecha=rs2.getString("fecha");
        }
  
    
%>
<style>
    tr:hover {color:#ffffff ; background-color: #001940;}
</style>
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" >
      <a href="manuales/Consumo_balanceados.pdf" target="_blank">Manual de usuario</a>
</div></head><!-- comment -->
<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                ITKV
            </div>
        </div>
        <center><b>REGISTRO DE CONSUMO BALANCEADOS</b></center>
    </div>
</div> 

<form id="form_add_consumo" method="post" >

 <b>Fecha de registro</b> <br>
 <input type="text" class="datepicker "   value="<%=fecha%>" required id="fecha">
 <hr>
    <br>
    <strong ><a>Responsable</a></strong>
    
    <select class="form-control selectpicker" id="retirado_por_select" onchange="insert_valor_responsable_combo_itkv()"  data-live-search="true">
    <option value="">Seleccione</option>    
        <%  while (rs.next()) {%>
        <option><%=rs.getString("U_retiradopor")%></option>    
        <% }%>
        <option>OTROS</option>    
    </select>
     <input type="text" class="form-control " placeholder="INGRESE NOMBRE" value=""   id="retirado_por" style="display: none">
        
    <strong><a>Ubicacion</a></strong>
    <select class="form-control selectpicker " data-live-search="true" id="ubicacion">
        <%  while (rs3.next()) 
        {%>
        <option value="<%=rs3.getString("PrcCODE")%>" desc="<%=rs3.getString("PrcName")%>" > 
            <%=rs3.getString("PrcName")%>
        </option>    
        <% }%>
    </select> 

    <strong ><a>Actividad</a></strong>
    <select class="form-control" id="actividad">
        <%  while (rsActividad.next()) {%>
        <option value="<%=rsActividad.getString("PrcCODE")%>" desc="<%=rsActividad.getString("PrcName")%>"><%=rsActividad.getString("PrcName")%></option>    
        <% }%>
    </select> 

    <strong ><a>Rubro</a></strong>
    <select class="form-control" id="rubro">
        <%  while (rsRubro.next()) {%>
        <option value="<%=rsRubro.getString("PrcCODE")%>" desc="<%=rsRubro.getString("PrcName")%>"><%=rsRubro.getString("PrcName")%></option>    
        <% }%>
    </select> 
    
    
    
  

    
    <table   class="table table-striped table-bordered"  >
            <thead>
                <tr>
                    <th >  <strong ><a>Balanceado</a></strong>
    <select class="form-control selectpicker" data-live-search="true"  id="item">
        <%  while (rsBalanceado.next()) {%>
        <option value="<%=rsBalanceado.getString("itemcode")%>" desc="<%=rsBalanceado.getString("itemname")%>"><%=rsBalanceado.getString("itemname")%></option>    
        <% }%>
    </select></th>
    <th><input type="number"  class=" form-control"  id="cantidad" placeholder="Ingrese cantidad"></th>
    <th> <input type="button" value="Agregar item" class=" form-control  bg-navy" onclick="cargar_grilla_salida_repuesto();"></th>
                  </tr>
            </thead>
            
        </table>    
    
    
    
    
<table id="tabla" class="table table-striped table-bordered"  style='width:100%' >
            <thead>
                <tr>
                    <th >CODIGO</th>
                    <th>ARTICULO</th>
                    <th>CANTIDAD</th>
                    <th>ACCION</th>
                 </tr>
            </thead>
            <tbody id="tbody_tabla">

            </tbody>
        </table>    

    <div class="modal-footer align-right " >
        <input  class="btn bg-danger"  type="submit"   value="REGISTRAR" >
         
 

    </div>
</form>

 
<%
    } catch (Exception e) {
        out.print(e.getMessage());
    } finally {
        connection.close();
    }%>