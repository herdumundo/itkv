<%-- 
    Document   : consulta_cargar_aviario_fecha
    Created on : 07/03/2022, 15:08:27
    Author     : csanchez
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="application/json; charset=utf-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
  <% 
    clases.controles.connectarBD();
     JSONObject obje = new JSONObject();
    obje = new JSONObject();
    try {
            
        String fecha1= request.getParameter("idfechad") ;
        String avia= request.getParameter("avia") ;
        String grilla_html="";
        String grilla_htmlb="";
        String grilla_htmlh="";
        String grilla_html_descarte="";
        String grilla_html_pre_descarte="";
        String aviario = "";
        String lote = "";
        String dias = "";
        String sems = "";
        String saldoini = "";
        String saldoant = "";
        String muer = "";
        String via = "";
        String cant= "";
        String kg = "";
        String calcico = "";
        String tmin = "";
        String tmax = "";
        String onclick="";
        String coltempmin="";
        String coltempmax="";
        String arrow="";
        String arrow_pro="";
        String arrow_gramo_ave="";
        String color_gramo="";
        
        String transferin = "";
        String transferout= "";
        String ventas = "";
        String  ajuste = "";
        
        String lotename = "";
        
        String gramo_ave = "";
        String pro = "";
        //A
        Integer saldo_ant_total=0;
        Integer muer_total=0;
        Integer ti_total=0;
        Integer ts_total=0;
        Integer su_total=0;
        Integer aj_total=0;
        Integer ve_total=0;
        Integer saldo_total=0;
        Integer unidad_total=0;
        Integer kg_total=0;
        Integer calcico_total=0;
        
        //B
        Integer saldo_ant_totalb=0;
        Integer muer_totalb=0;
        Integer ti_totalb=0;
        Integer ts_totalb=0;
        Integer su_totalb=0;
        Integer aj_totalb=0;
        Integer ve_totalb=0;
        Integer saldo_totalb=0;
        Integer unidad_totalb=0;
        Integer kg_totalb=0;
        Integer calcico_totalb=0;
        
        //H
        Integer saldo_ant_totalh=0;
        Integer muer_totalh=0;
        Integer ti_totalh=0;
        Integer ts_totalh=0;
        Integer su_totalh=0;
        Integer aj_totalh=0;
        Integer ve_totalh=0;
        Integer saldo_totalh=0;
        Integer unidad_totalh=0;
        Integer kg_totalh=0;
        Integer calcico_totalh=0;
        
        //H3
        Integer saldo_ant_totalh3=0;
        Integer muer_totalh3=0;
        Integer ti_totalh3=0;
        Integer ts_totalh3=0;
        Integer su_totalh3=0;
        Integer aj_totalh3=0;
        Integer ve_totalh3=0;
        Integer saldo_totalh3=0;
        Integer unidad_totalh3=0;
        Integer kg_totalh3=0;
        Integer calcico_totalh3=0;
        
        String cabecera_pre_descarte = "  "
            + "    <div style='width: 100% !important  margin-left: 60%';' class='h_d2 text-center'>"
                + "<br>"
                + "<br>"
            + "<div style='width: 100% !important;' class='card-header bg-navy'>"
            + "    <h5 class='text-center'>Pre-Descarte Convencionales</h5>"
            + "</div>"
                + "<br>"
               ;
        
        String cabecera = "  "
            + "    <div style='width: 100% !important  margin-left: 60%';' class='h_d2 text-center'>"
                + "<br>"
                + "<br>"
            + "<div style='width: 100% !important;' class='card-header bg-navy'>"
            + "    <h5 class='text-center'>Mecanizados A</h5>"
            + "</div>"
                + "<br>"
            + "<table class=' table-bordered tablagrilla compact-cs'>"
               + "             <thead>"
               + "                 <tr>"
               + "                     <th rowspan='2' class='text-center bg-navy tablagrilla' width='50'>Aviario</th>"
               + "                     <th rowspan='2' class='text-center bg-navy tablagrilla' width='70'>Lote</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Edad</th>"
               + "                     <th colspan='11' class='text-center bg-navy tablagrilla'>Aves</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Huevos</th>"
               + "                     <th colspan='3' class='text-center bg-navy tablagrilla'>Balanceados</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Temp. Int.</th>"
               + "                 </tr>"
               + "                 <tr>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>días</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='40'>sems.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo ini.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo ant.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>muer.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>% mort.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>TI</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>TS</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>SU</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>AJ</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>VE</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>%Viab.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Unid.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>% Prod.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Kg.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>gr/ave</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Calcico</th>"
                + "                    <th class='text-center bg-navy tablagrilla' width='60'>T.máx.</th>"
               + "                    <th class='text-center bg-navy tablagrilla' width='60'>T.mín.</th>"
               
                + "                    </tr>"
                + "                    </thead>"
                + "                    <tbody>";
        String cabecerab = "  "
            + "    <div style='width: 100% !important  margin-left: 60%';' class='h_d2 text-center'>"
                + "<br>"
                + "<br>"
            + "<div style='width: 100% !important;' class='card-header bg-navy'>"
            + "    <h5 class='text-center'>Mecanizados B</h5>"
            + "</div>"
                + "<br>"
            + "<table class=' table-bordered tablagrilla compact-cs'>"
               + "             <thead>"
               + "                 <tr>"
               + "                     <th rowspan='2' class='text-center bg-navy tablagrilla' width='50'>Aviario</th>"
               + "                     <th rowspan='2' class='text-center bg-navy tablagrilla' width='70'>Lote</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Edad</th>"
               + "                     <th colspan='11' class='text-center bg-navy tablagrilla'>Aves</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Huevos</th>"
               + "                     <th colspan='3' class='text-center bg-navy tablagrilla'>Balanceados</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Temp. Int.</th>"
               + "                 </tr>"
               + "                 <tr>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>días</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='40'>sems.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo ini.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo ant.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>muer.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>% mort.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>TI</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>TS</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>SU</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>AJ</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>VE</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>%Viab.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Unid.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>% Prod.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Kg.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>gr/ave</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Calcico</th>"
               + "                    <th class='text-center bg-navy tablagrilla' width='60'>T.máx.</th>"
               + "                    <th class='text-center bg-navy tablagrilla' width='60'>T.mín.</th>"
               
               + "                    </tr>"
               + "                    </thead>"
               + "                    <tbody>";
        String cabecerah = "  "
            + "    <div style='width: 100% !important  margin-left: 60%';' class='h_d2 text-center'>"
                + "<br>"
                + "<br>"
            + "<div style='width: 100% !important;' class='card-header bg-navy'>"
            + "    <h5 class='text-center'>Mecanizados H</h5>"
            + "</div>"
                + "<br>"
            + "<table class=' table-bordered tablagrilla compact-cs'>"
               + "             <thead>"
               + "                 <tr>"
               + "                     <th rowspan='2' class='text-center bg-navy tablagrilla' width='50'>Aviario</th>"
               + "                     <th rowspan='2' class='text-center bg-navy tablagrilla' width='70'>Lote</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Edad</th>"
               + "                     <th colspan='11' class='text-center bg-navy tablagrilla'>Aves</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Huevos</th>"
               + "                     <th colspan='3' class='text-center bg-navy tablagrilla'>Balanceados</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Temp. Int.</th>"
               + "                 </tr>"
               + "                 <tr>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>días</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='40'>sems.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo ini.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo ant.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>muer.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>% mort.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>TI</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>TS</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>SU</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>AJ</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>VE</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>%Viab.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Unid.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>% Prod.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Kg.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>gr/ave</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Calcico</th>"
                + "                    <th class='text-center bg-navy tablagrilla' width='60'>T.máx.</th>"
               + "                    <th class='text-center bg-navy tablagrilla' width='60'>T.mín.</th>"
               
                + "                    </tr>"
                + "                    </thead>"
                + "                    <tbody>";
        String cabecera_descarte = "  "
            + "    <div style='width: 100% !important  margin-left: 60%';' class='h_d2 text-center'>"
                + "<br>"
                + "<br>"
            + "<div style='width: 100% !important;' class='card-header bg-navy'>"
            + "    <h5 class='text-center'>Mecanizados Descarte</h5>"
            + "</div>"
                + "<br>"
            + "<table class=' table-bordered tablagrilla compact-cs'>"
               + "             <thead>"
               + "                 <tr>"
               + "                     <th rowspan='2' class='text-center bg-navy tablagrilla' width='50'>Aviario</th>"
               + "                     <th rowspan='2' class='text-center bg-navy tablagrilla' width='70'>Lote</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Edad</th>"
               + "                     <th colspan='11' class='text-center bg-navy tablagrilla'>Aves</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Huevos</th>"
               + "                     <th colspan='3' class='text-center bg-navy tablagrilla'>Balanceados</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Temp. Int.</th>"
               + "                 </tr>"
               + "                 <tr>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>días</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='40'>sems.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo ini.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo ant.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>muer.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>% mort.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>TI</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>TS</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>SU</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>AJ</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>VE</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>%Viab.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Unid.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>% Prod.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Kg.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>gr/ave</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Calcico</th>"
                + "                    <th class='text-center bg-navy tablagrilla' width='60'>T.máx.</th>"
               + "                    <th class='text-center bg-navy tablagrilla' width='60'>T.mín.</th>"
               
                + "                    </tr>"
                + "                    </thead>"
                + "                    <tbody>";

   
   
    //PreparedStatement pt=con.prepareStatement("select case  when  fila % 2 =0 then 'green' else 'red' end as color, fila, sum(cant) as cant from ppr_contador where fecha BETWEEN '"+fecha1+"'and '"+fecha2+"'and aviario='"+aviario+"'group by fila");
     //PreparedStatement pt=con.prepareStatement("select idusuario,nombreusuario from tab_mae_ppr_log");
    //PreparedStatement pt=con.prepareStatement("select '#ff0000' as min1, '#e10000' as min2,'#e10000' as min3, '#007d3c' as prom, '#007d50' as prom1 , '#007d97' as prom2, '#007dff' as prom3, fila, sum(cant) as cant from ppr_contador where fecha BETWEEN '"+fecha1+"'and '"+fecha2+"'and aviario='"+aviario+"'group by fila");
    PreparedStatement pt=clases.controles.connect.prepareStatement("execute stp_mae_ppr_select_datos_diarios_descarte_h  @fecha_desde='"+fecha1+"'");
    ResultSet rs=pt.executeQuery();
    ArrayList Fila = new ArrayList();
    
    //ArrayList fe1 = new ArrayList();
   // ArrayList fe2 = new ArrayList();
            while(rs.next()) {
                if(rs.getString("aviario").startsWith("A")){
                grilla_html = grilla_html + "<tr class='tablagrilla'><td class='tablagrilla' style= 'text-align:center;'>"
                + " " + rs.getString("aviario") + " </td> <td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("lote") + "  </td>"
                        + "<td class='tablagrilla cero tdc' style= 'text-align:center;color:' ;> " + rs.getString("dias") +"  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colorsem") + "' style= 'text-align:center;color:" + rs.getString("colorl") + "'>  " + rs.getString("sems") + "  </td>"
                        + "<td class='tablagrilla cero si' style= 'text-align:center';>  " + rs.getString("saldoini2") + " </td><td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("saldoant") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("muer") +" <i class='" + rs.getString("arrow") +"'></i> </td>"
                        + "<td onclick='carga_aviario_fecha_ppr(\"" + rs.getString("onclick") + "\")' class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("mor") +'%'+ "  </td>"
                        + "<td onclick='carga_aviario_fecha_ppr(\"" + rs.getString("onclick") + "\")' class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TI") + "  </td>"
                        + "<td onclick='carga_aviario_fecha_ppr(\"" + rs.getString("onclick") + "\")' class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TS") + "  </td>"
                        + "<td onclick='carga_aviario_fecha_ppr(\"" + rs.getString("onclick") + "\")' class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TS") + "  </td>"
                        + "<td onclick='carga_aviario_fecha_ppr(\"" + rs.getString("onclick") + "\")' class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("AJ") + "  </td>"
                        + "<td onclick='carga_aviario_fecha_ppr(\"" + rs.getString("onclick") + "\")' class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("VE") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("saldo12") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("via") +'%'+ "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("cant") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("pro")  +'%'+ " <i class='" + rs.getString("arrow_pro") +"'></i> </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("kg") + "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colorgramo") +" ' style= 'text-align:center';>  " + rs.getString("gramo_ave") +" <i class='" + rs.getString("arrow_gramo_ave") +"'></i> </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("calcico") + "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colortemp2") + "' style= 'text-align:center';>  " + rs.getString("tmax") +'°'+'C'+ "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colortemp") + "' style= 'text-align:center';>  " + rs.getString("tmin") +'°'+'C'+ "  </td></tr>";
                saldo_ant_total=(saldo_ant_total)+Integer.parseInt(rs.getString("saldoant"));
                muer_total=(muer_total)+Integer.parseInt(rs.getString("muer"));
                ti_total=(ti_total)+Integer.parseInt(rs.getString("ti"));
                ts_total=(ts_total)+Integer.parseInt(rs.getString("ts"));
                su_total=(su_total)+Integer.parseInt(rs.getString("ti"));
                aj_total=(aj_total)+Integer.parseInt(rs.getString("aj"));
                ve_total=(ve_total)+Integer.parseInt(rs.getString("ve"));
                saldo_total=(saldo_total)+Integer.parseInt(rs.getString("saldo12"));
                unidad_total=(unidad_total)+Integer.parseInt(rs.getString("cant"));
                kg_total=(kg_total)+Integer.parseInt(rs.getString("kg"));
                calcico_total=(calcico_total)+Integer.parseInt(rs.getString("calcico"));

         
                }
                if(rs.getString("aviario").startsWith("B")){
                grilla_htmlb = grilla_htmlb + "<tr class='tablagrilla'><td class='tablagrilla' style= 'text-align:center;'>"
                + " " + rs.getString("aviario") + " </td> <td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("lote") + "  </td>"
                        + "<td class='tablagrilla cero tdc' style= 'text-align:center;color:' ;> " + rs.getString("dias") +"  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colorsem") + "' style= 'text-align:center;color:" + rs.getString("colorl") + "'>  " + rs.getString("sems") + "  </td>"
                        + "<td class='tablagrilla cero si' style= 'text-align:center';>  " + rs.getString("saldoini2") + " </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("saldoant") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("muer") +" <i class='" + rs.getString("arrow") +"'></i> </td>"
                        + "<td onclick='carga_aviario_fecha_ppr(\"" + rs.getString("onclick") + "\")' class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("mor") +'%'+ "  </td>"
                        + "<td onclick='carga_aviario_fecha_ppr(\"" + rs.getString("onclick") + "\")' class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TI") + "  </td>"
                        + "<td onclick='carga_aviario_fecha_ppr(\"" + rs.getString("onclick") + "\")' class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TS") + "  </td>"
                        + "<td onclick='carga_aviario_fecha_ppr(\"" + rs.getString("onclick") + "\")' class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TS") + "  </td>"
                        + "<td onclick='carga_aviario_fecha_ppr(\"" + rs.getString("onclick") + "\")' class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("AJ") + "  </td>"
                        + "<td onclick='carga_aviario_fecha_ppr(\"" + rs.getString("onclick") + "\")' class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("VE") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("saldo12") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("via") +'%'+ "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("cant") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("pro") +" <i class='" + rs.getString("arrow_pro") +"'></i> </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("kg") + "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colorgramo") +" ' style= 'text-align:center';>  " + rs.getString("gramo_ave") +" <i class='" + rs.getString("arrow_gramo_ave") +"'></i> </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("calcico") + "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colortemp2") + "' style= 'text-align:center';>  " + rs.getString("tmax") +'°'+'C'+ "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colortemp") + "' style= 'text-align:center';>  " + rs.getString("tmin") +'°'+'C'+ "  </td></tr>";
                saldo_ant_totalb=(saldo_ant_totalb)+Integer.parseInt(rs.getString("saldoant"));
                muer_totalb=(muer_totalb)+Integer.parseInt(rs.getString("muer"));
                ti_totalb=(ti_totalb)+Integer.parseInt(rs.getString("ti"));
                ts_totalb=(ts_totalb)+Integer.parseInt(rs.getString("ts"));
                su_totalb=(su_totalb)+Integer.parseInt(rs.getString("ti"));
                aj_totalb=(aj_totalb)+Integer.parseInt(rs.getString("aj"));
                ve_totalb=(ve_totalb)+Integer.parseInt(rs.getString("ve"));
                saldo_totalb=(saldo_totalb)+Integer.parseInt(rs.getString("saldoant"));
                unidad_totalb=(unidad_totalb)+Integer.parseInt(rs.getString("cant"));
                kg_totalb=(kg_totalb)+Integer.parseInt(rs.getString("kg"));
                calcico_totalb=(calcico_totalb)+Integer.parseInt(rs.getString("calcico"));
                } 
                if(rs.getString("aviario").startsWith("H")){
                grilla_htmlh = grilla_htmlh + "<tr class='tablagrilla'><td class='tablagrilla' style= 'text-align:center;'>"
                + " " + rs.getString("aviario") + " </td> <td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("lote") + "  </td>"
                        + "<td class='tablagrilla cero tdc' style= 'text-align:center;color:' ;> " + rs.getString("dias") +"  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colorsem") + "' style= 'text-align:center;color:" + rs.getString("colorl") + "'>  " + rs.getString("sems") + "  </td>"
                        + "<td class='tablagrilla cero si' style= 'text-align:center';>  " + rs.getString("saldoini2") + " </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("saldoant") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("muer") +" <i class='" + rs.getString("arrow") +"'></i> </td>"
                        + "<td onclick='carga_aviario_fecha_ppr(\"" + rs.getString("onclick") + "\")' class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("mor") +'%'+ "  </td>"
                        + "<td onclick='carga_aviario_fecha_ppr(\"" + rs.getString("onclick") + "\")' class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TI") + "  </td>"
                        + "<td onclick='carga_aviario_fecha_ppr(\"" + rs.getString("onclick") + "\")' class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TS") + "  </td>"
                        + "<td onclick='carga_aviario_fecha_ppr(\"" + rs.getString("onclick") + "\")' class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TS") + "  </td>"
                        + "<td onclick='carga_aviario_fecha_ppr(\"" + rs.getString("onclick") + "\")' class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("AJ") + "  </td>"
                        + "<td onclick='carga_aviario_fecha_ppr(\"" + rs.getString("onclick") + "\")' class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("VE") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("saldo12") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("via") +'%'+ "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("cant") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("pro") +" <i class='" + rs.getString("arrow_pro") +"'></i> </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("kg") + "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colorgramo") +" ' style= 'text-align:center';>  " + rs.getString("gramo_ave") +" <i class='" + rs.getString("arrow_gramo_ave") +"'></i> </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("calcico") + "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colortemp2") + "' style= 'text-align:center';>  " + rs.getString("tmax") +'°'+'C'+ "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colortemp") + "' style= 'text-align:center';>  " + rs.getString("tmin") +'°'+'C'+ "  </td></tr>";
                saldo_ant_totalh=(saldo_ant_totalh)+Integer.parseInt(rs.getString("saldoant"));
                muer_totalh=(muer_totalh)+Integer.parseInt(rs.getString("muer"));
                ti_totalh=(ti_totalh)+Integer.parseInt(rs.getString("ti"));
                ts_totalh=(ts_totalh)+Integer.parseInt(rs.getString("ts"));
                su_totalh=(su_totalh)+Integer.parseInt(rs.getString("ti"));
                aj_totalh=(aj_totalh)+Integer.parseInt(rs.getString("aj"));
                ve_totalh=(ve_totalh)+Integer.parseInt(rs.getString("ve"));
                saldo_totalh=(saldo_totalh)+Integer.parseInt(rs.getString("saldoant"));
                unidad_totalh=(unidad_totalh)+Integer.parseInt(rs.getString("cant"));
                kg_totalh=(kg_totalh)+Integer.parseInt(rs.getString("kg"));
                calcico_totalh=(calcico_totalh)+Integer.parseInt(rs.getString("calcico"));
                } 
                
        aviario = rs.getString("aviario");
        lote = rs.getString("lote");
        dias = rs.getString("dias");
        sems = rs.getString("sems");
        saldoini = rs.getString("saldoini2");
        saldoant = rs.getString("saldoant");
        muer = rs.getString("muer");
        via = rs.getString("via");
        cant= rs.getString("cant");
        kg = rs.getString("kg");
        calcico = rs.getString("calcico");
        tmin = rs.getString("tmin");
        tmax = rs.getString("tmax");
        onclick = rs.getString("onclick");
        coltempmin = rs.getString("colortemp");
        coltempmax = rs.getString("colortemp2");
        arrow = rs.getString("arrow");
        arrow_pro = rs.getString("arrow_pro");
        color_gramo = rs.getString("colorgramo");
        arrow_gramo_ave = rs.getString("arrow_gramo_ave");
               
              }
            
            PreparedStatement pt2=clases.controles.connect.prepareStatement("execute stp_mae_ppr_select_datos_diarios_descarte_h3 @fecha_desde='"+fecha1+"'");
    ResultSet rs2=pt2.executeQuery();
    
    //ArrayList fe1 = new ArrayList();
   // ArrayList fe2 = new ArrayList();
            while(rs2.next()) {
                
                grilla_html_descarte = grilla_html_descarte + "<tr class='tablagrilla'><td class='tablagrilla' style= 'text-align:center;'>"
                + " " + rs2.getString("aviario") + " </td> <td class='tablagrilla cero ' style= 'text-align:center';>  " + rs2.getString("lote") + "  </td>"
                        + "<td class='tablagrilla cero tdc' style= 'text-align:center;color:' ;> " + rs2.getString("dias") +"  </td>"
                        + "<td class='tablagrilla cero " + rs2.getString("colorsem") + "' style= 'text-align:center;color:" + rs2.getString("colorl") + "'>  " + rs2.getString("sems") + "  </td>"
                        + "<td class='tablagrilla cero si' style= 'text-align:center';>  " + rs2.getString("saldoini2") + " </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs2.getString("saldoant") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs2.getString("muer") +" <i class='" + rs2.getString("arrow") +"'></i> </td>"
                        + "<td onclick='carga_aviario_fecha_ppr(\"" + rs2.getString("onclick") + "\")' class='tablagrilla cero ' style= 'text-align:center';>  " + rs2.getString("mor") +'%'+ "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs2.getString("TI") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs2.getString("TS") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs2.getString("TS") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs2.getString("AJ") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs2.getString("VE") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs2.getString("saldo") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs2.getString("via") +'%'+ "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs2.getString("cant") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs2.getString("pro") +" <i class='" + rs2.getString("arrow_pro") +"'></i> </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs2.getString("kg") + "  </td>"
                        + "<td class='tablagrilla cero " + rs2.getString("colorgramo") +" ' style= 'text-align:center';>  " + rs2.getString("gramo_ave") +" <i class='" + rs2.getString("arrow_gramo_ave") +"'></i> </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs2.getString("calcico") + "  </td>"
                        + "<td class='tablagrilla cero " + rs2.getString("colortemp2") + "' style= 'text-align:center';>  " + rs2.getString("tmax") +'°'+'C'+ "  </td>"
                        + "<td class='tablagrilla cero " + rs2.getString("colortemp") + "' style= 'text-align:center';>  " + rs2.getString("tmin") +'°'+'C'+ "  </td></tr>";
                saldo_ant_totalh3=(saldo_ant_totalh3)+Integer.parseInt(rs2.getString("saldoant"));
                muer_totalh3=(muer_totalh3)+Integer.parseInt(rs2.getString("muer"));
                ti_totalh3=(ti_totalh3)+Integer.parseInt(rs2.getString("ti"));
                ts_totalh3=(ts_totalh3)+Integer.parseInt(rs2.getString("ts"));
                su_totalh3=(su_totalh3)+Integer.parseInt(rs2.getString("ti"));
                aj_totalh3=(aj_totalh3)+Integer.parseInt(rs2.getString("aj"));
                ve_totalh3=(ve_totalh3)+Integer.parseInt(rs2.getString("ve"));
                saldo_totalh3=(saldo_totalh3)+Integer.parseInt(rs2.getString("saldoant"));
                unidad_totalh3=(unidad_totalh3)+Integer.parseInt(rs2.getString("cant"));
                kg_totalh3=(kg_totalh3)+Integer.parseInt(rs2.getString("kg"));
                calcico_totalh3=(calcico_totalh3)+Integer.parseInt(rs2.getString("calcico"));
                
        aviario = rs2.getString("aviario");
        lote = rs2.getString("lote");
        dias = rs2.getString("dias");
        sems = rs2.getString("sems");
        saldoini = rs2.getString("saldoini2");
        saldoant = rs2.getString("saldoant");
        muer = rs2.getString("muer");
        via = rs2.getString("via");
        cant= rs2.getString("cant");
        kg = rs2.getString("kg");
        calcico = rs2.getString("calcico");
        tmin = rs2.getString("tmin");
        tmax = rs2.getString("tmax");
        onclick = rs2.getString("onclick");
        coltempmin = rs2.getString("colortemp");
        coltempmax = rs2.getString("colortemp2");
        arrow = rs2.getString("arrow");
        arrow_pro = rs2.getString("arrow_pro");
        color_gramo = rs2.getString("colorgramo");
        arrow_gramo_ave = rs2.getString("arrow_gramo_ave");
               
              }
            
            PreparedStatement pt3=clases.controles.connect.prepareStatement("execute stp_mae_ppr_select_datos_diarios_pre_descarte @fecha_desde='"+fecha1+"'");
    ResultSet rs3=pt3.executeQuery();

    
    //ArrayList fe1 = new ArrayList();
   // ArrayList fe2 = new ArrayList();
            while(rs3.next()) {
                
                grilla_html_pre_descarte = grilla_html_pre_descarte + "<table class=' table-bordered tablagrilla compact-cs'>"
               + "             <thead>"
                + "<tr>"
                + "        <th class='bg-warning' colspan='14'>Lote: " + rs3.getString("lote_name") + "</th>"
                + "    </tr>"
               + "                 <tr>    "
               + "                     <th class='text-center bg-navy tablagrilla'width='92' height='10'>Edad (d)</th>"
               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>Edad (s)</th>"
               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>Saldo ant.</th>"
               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>Muertos</th>"
               + "                      <th class='text-center bg-navy tablagrilla'width='92'height='10'>T.I.</th>"
               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>T.S.</th>"
               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>Ventas</th>"
               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>Subprod.</th>"

               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>Ajustes</th>"
               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>Saldo</th>"
               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>Balanceados</th>"
               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>gr/ave</th>"
               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>Huevos</th>"
               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>% Prod.</th>"
               + "                  </tr>   "
               + "                </thead>     "
                        + "                <br>     "
               + "                <tbody>     "
                        + "<tr class='tablagrilla'><td onclick='dd_mec2_pre_des_convencionales_ppr()' class='tablagrilla' style= 'text-align:center;'>"
                + " " + rs3.getString("edaddias") + " </td> <td class='tablagrilla cero ' style= 'text-align:center';>  " + rs3.getString("edadsems") + "  </td>"
                        + "<td class='tablagrilla cero tdc' style= 'text-align:center;color:' ;> " + rs3.getString("saldoant") +"  </td>"
                        + "<td class='tablagrilla cero " 
                        + rs3.getString("muertos") + "' style= 'text-align:center;color:'>  " + rs3.getString("transferin") + "  </td>"
                        + "<td class='tablagrilla cero si' style= 'text-align:center';>  " + rs3.getString("transferout") + " </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs3.getString("ventas") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs3.getString("ajuste") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs3.getString("saldoaves") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs3.getString("kg") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs3.getString("gramo_ave") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs3.getString("pro") + "  </td></tr>";
                
        dias = rs3.getString("edaddias");
        sems = rs3.getString("edadsems");
        saldoant = rs3.getString("saldoant");
        muer = rs3.getString("muertos");
        transferin = rs3.getString("transferin");
        transferout= rs3.getString("transferout");
        ventas = rs3.getString("ventas");
        ajuste = rs3.getString("ajuste");
        saldoini = rs3.getString("saldoaves");
        lotename = rs3.getString("lote_name");
        kg = rs3.getString("kg");
        gramo_ave = rs3.getString("gramo_ave");
        pro = rs3.getString("pro");
        
              }
            
           // clases.controles.connect.close();
    obje.put("grilla_datos_diarios",cabecera + grilla_html + "</tbody><tfoot class='total'><tr>"
                          +"  <td class='text-left bg-gray' colspan='5'>TOTAL</td>"
                           +" <td class='text-center bg-gray'>"+saldo_ant_total+"</td>"
                           +" <td class='text-center bg-gray'>"+muer_total+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'>"+ti_total+"</td>"
                           +" <td class='text-center bg-gray'>"+ts_total+"</td>"
                           +" <td class='text-center bg-gray'>"+su_total+"</td>"
                           +" <td class='text-center bg-gray'>"+aj_total+"</td>"
                           +" <td class='text-center bg-gray'>"+ve_total+"</td>"
                           +" <td class='text-center bg-gray'>"+saldo_total+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                            +"<td class='text-center bg-gray'>"+unidad_total+"</td>"
                            +"<td class='text-center bg-gray'></td>"
                            +"<td class='text-center bg-gray'>"+kg_total+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'>"+calcico_total+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'></td>"
                       +" </tr>"
                    +"</tfoot></body></div></div>" );

    obje.put("grilla_datos_diariosb",cabecerab + grilla_htmlb + "</tbody><tfoot class='total'><tr>"
                          +"  <td class='text-left bg-gray' colspan='5'>TOTAL</td>"
                           +" <td class='text-center bg-gray'>"+saldo_ant_totalb+"</td>"
                           +" <td class='text-center bg-gray'>"+muer_totalb+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'>"+ti_totalb+"</td>"
                           +" <td class='text-center bg-gray'>"+ts_totalb+"</td>"
                           +" <td class='text-center bg-gray'>"+su_totalb+"</td>"
                           +" <td class='text-center bg-gray'>"+aj_totalb+"</td>"
                           +" <td class='text-center bg-gray'>"+ve_totalb+"</td>"
                           +" <td class='text-center bg-gray'>"+saldo_totalb+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                            +"<td class='text-center bg-gray'>"+unidad_totalb+"</td>"
                            +"<td class='text-center bg-gray'></td>"
                            +"<td class='text-center bg-gray'>"+kg_totalb+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'>"+calcico_totalb+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'></td>"
                       +" </tr>"
                    +"</tfoot></body></div>" );
    obje.put("grilla_datos_diariosh",cabecerah + grilla_htmlh + "</tbody><tfoot class='total'><tr>"
                          +"  <td class='text-left bg-gray' colspan='5'>TOTAL</td>"
                           +" <td class='text-center bg-gray'>"+saldo_ant_totalh+"</td>"
                           +" <td class='text-center bg-gray'>"+muer_totalh+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'>"+ti_totalh+"</td>"
                           +" <td class='text-center bg-gray'>"+ts_totalh+"</td>"
                           +" <td class='text-center bg-gray'>"+su_totalh+"</td>"
                           +" <td class='text-center bg-gray'>"+aj_totalh+"</td>"
                           +" <td class='text-center bg-gray'>"+ve_totalh+"</td>"
                           +" <td class='text-center bg-gray'>"+saldo_totalh+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                            +"<td class='text-center bg-gray'>"+unidad_totalh+"</td>"
                            +"<td class='text-center bg-gray'></td>"
                            +"<td class='text-center bg-gray'>"+kg_totalh+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'>"+calcico_totalh+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'></td>"
                       +" </tr>"
                    +"</tfoot></body></div>" );
    obje.put("grilla_datos_diarios_descarte",cabecera_descarte + grilla_html_descarte + "</tbody><tfoot class='total'><tr>"
                          +"  <td class='text-left bg-gray' colspan='5'>TOTAL</td>"
                           +" <td class='text-center bg-gray'>"+saldo_ant_totalh3+"</td>"
                           +" <td class='text-center bg-gray'>"+muer_totalh3+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'>"+ti_totalh3+"</td>"
                           +" <td class='text-center bg-gray'>"+ts_totalh3+"</td>"
                           +" <td class='text-center bg-gray'>"+su_totalh3+"</td>"
                           +" <td class='text-center bg-gray'>"+aj_totalh3+"</td>"
                           +" <td class='text-center bg-gray'>"+ve_totalh3+"</td>"
                           +" <td class='text-center bg-gray'>"+saldo_totalh3+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                            +"<td class='text-center bg-gray'>"+unidad_totalh3+"</td>"
                            +"<td class='text-center bg-gray'></td>"
                            +"<td class='text-center bg-gray'>"+kg_totalh3+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'>"+calcico_totalh3+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'></td>"
                       +" </tr>"
                    +"</tfoot></body></div>" );
    obje.put("grilla_datos_diarios_pre_descarte",cabecera_pre_descarte + grilla_html_pre_descarte + "</tbody></body></div>" );
    obje.put("tmin",tmin );
    obje.put("aviario",aviario );
    obje.put("fecha1",fecha1 );
    obje.put("avia",avia );


        } catch (Exception e) {
        }
    finally{
            out.print(obje); 
               clases.controles.DesconnectarBD();
    }
 %>
