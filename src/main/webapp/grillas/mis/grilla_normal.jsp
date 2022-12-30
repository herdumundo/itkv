
<%@page import="clases.controles"%>
<%@page import="javax.swing.JOptionPane"%>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@include  file="../../chequearsesion.jsp" %>
 
<% 
    clases.controles.VerificarConexion();
    Connection cn = controles.connectSesion;
    // Asignar conexion al objeto manejador de datos
    fuente.setConexion(cn);
    //Parametros
    String calendario    = request.getParameter("calendario_informe");
    String area = (String) sesionOk.getAttribute("clasificadora"); %>
   
    <table    id="grilla_registros" class="table" data-row-style="rowStyle" data-toggle="table" data-click-to-select="true">
                               
        <thead>    <tr>
                        <th>Fecha clasifi</th>
                        <th>Nro. carro</th>
                        <th>Nro. MESA</th>
                        <th>Tipo</th>
                        <th>Categoria</th>
                        <th>Fecha puesta </th>
                        <th>Hora</th>
                        <th>Responsable clasificaci�n</th>
                        <th>U.medida</th> 
                        <th>Cantidad</th> 
                        <th>Aviario</th> 
                        <th>Empacadora</th> 
                        <th>T.almacenamiento</th>  
                        <th>Liberado por</th> 
                        <th>Comentario</th> 
                        <th>Estado liberaci�n</th> 
    </tr></thead>
        <tbody>
        <%
      
      
         ResultSet rs = fuente.obtenerDato(""
                 + "select convert(varchar(10),fecha,111) as 'Fecha de clasificaci�n',"
                 + "cod_carrito as 'Nro. de carro',tipo_huevo as 'Tipo de huevo',"
                 + "cod_clasificacion as 'Categoria',convert(varchar,fecha_puesta,111) as 'Fecha de puesta',"
                 + " case	when  hora_inicio is NULL	then hora_clasificacion	else   concat(FORMAT(hora_inicio,'HH:mm dd/MM/yyyy'),CHAR(13) + CHAR(10),FORMAT(hora_fin,'HH:mm dd/MM/yyyy'))	end as  'Hora de clasificaci�n',"
                 + "cod_lote as 'Lote',"
                 + "resp_clasificacion as 'Responsable de clasificaci�n',u_medida as 'Unidad de medida',"
                 + "cantidad as Cantidad,estado as Estado,clasificadora as Clasificadora,aviario as Aviario,"
                 + "empacadora as Empacadora,tipo_almacenamiento as 'Tipo de almacenamiento',liberado_por as 'Liberado por',"
                 + "comentario as Comentario,estado_liberacion as 'Estado de liberaci�n', isnull(cod_cambio,'') "
                 + "from "
                 + "lotes where  tipo_huevo in ('R','RP','PI')  and convert(varchar,fecha,103)= '"+calendario+"'  and "
                    + "estado<>'e' and clasificadora_actual='"+area+"' order by tipo_huevo,cod_carrito");
       
     while(rs.next()){
         
         String estado= rs.getString(18);
         String nro_mesa= rs.getString(19);
            String fila="";
         String estado_liberacion="";
         if(estado.endsWith("Z")){
            
            estado_liberacion="R.";
                                }
         else  if(estado.endsWith("R")){
            
            estado_liberacion="R";
                                } 
            else  if(estado.endsWith("L")){
            
            estado_liberacion="L";
                                } 
            else {
                estado_liberacion="";
            }
        %> 
    <tr <%=fila%> > 
                            <td><%=rs.getString(1)%>    </td>
                            <td><%=rs.getString(2)%>    </td>
                            <td><%=nro_mesa%>    </td>
                            <td><%=rs.getString(3)%>    </td>
                            <td><%=rs.getString(4)%>    </td>
                            <td><%=rs.getString(5)%>    </td>
                            <td><%=rs.getString(6)%>    </td>
                            <td><%=rs.getString(8)%>    </td>  
                            <td><%=rs.getString(9)%>    </td>  
                            <td><%=rs.getString(10)%>   </td>  
                            <td><%=rs.getString(13)%>   </td>  
                            <td><%=rs.getString(14)%>   </td> 
                            <td><%=rs.getString(15)%>   </td>  
                            <td><%=rs.getString(16)%>   </td>  
                            <td><%=rs.getString(17)%>   </td>  
                            <td><%=estado_liberacion%>   </td>  
                             
                     
   </tr>  <% } %></tbody>    </table>
     
  
    <% cn.close();
clases.controles.DesconnectarBDsession();
%>