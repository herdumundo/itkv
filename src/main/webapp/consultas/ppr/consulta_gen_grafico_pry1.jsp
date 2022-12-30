<%-- 
    Document   : datos
    Created on : 02-ene-2022, 19:57:59
    Author     : aespinola
--%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="application/json; charset=utf-8"%>
<%@include  file="../../cruds/conexion.jsp" %>  
<%@include  file="../../chequearsesion.jsp" %>
<%   
   
    String id =  request.getParameter ("id");;
    JSONObject charts = new JSONObject();
    DecimalFormat formatea = new DecimalFormat("###,###.##");
  try {
    String grilla_html="";
    String grilla_html2="";
    String cabecera2="";
    
    Statement st,st2,st3;
    ResultSet rs,rs2,rs3 ;
    String  ultima_carga_ppr="0";
    int min=0;
    int max=0;
    st=connection.createStatement();
    st2=connection.createStatement();
    st3=connection.createStatement();
    String semana_barra="";
    int id_lote=0;
    rs=st.executeQuery("   select id, semanas,aves_carga,aves_padron,aviario,semana_barra,semana_lote_barra from v_ppr_pry_productividad_semanas where id="+id +" order by 2 asc" );
    
    rs2=st2.executeQuery(" select min(cantidad_aves) as min,max(cantidad_aves) as max from ppr_pry_det 	where id_cab="+id +"" );
    while(rs2.next()) 
    {
        min=rs2.getInt("min");
        max=rs2.getInt("max");
    } 
   
    rs3=st3.executeQuery(" select * from  v_ppr_pry_detalle_carga 	where id="+id+"" );
    while (rs3.next()) 
    {
        grilla_html = grilla_html
        + "<tr > "
        + "<td style=\"font-weight:bold\">" +   rs3.getString("fecha_carga")                    + "</td>"
        + "<td style=\"font-weight:bold\">" +   rs3.getString("fecha_carga")                    + "</td>"
        + "<td style=\"font-weight:bold\">" +   rs3.getString("semanas")                        + "</td>"
        + "<td style=\"font-weight:bold\">" +   formatea.format(rs3.getInt("aves_carga") )   + "</td>"
        + "<td style=\"font-weight:bold\">" +   rs3.getString("mortandad")                      + "</td>"
        + "<td style=\"font-weight:bold\">                                                      </td>"
        + "<td style=\"font-weight:bold\">" +   rs3.getString("tipo")                           + "</td>"
        + "</tr>";
        
         grilla_html2 = grilla_html2
        + "<tr > "
        + "<td style=\"font-weight:bold\">" +   rs3.getString("fecha_carga")                    + "</td>"
        + "<td style=\"font-weight:bold\">" +   rs3.getString("fecha_carga")                    + "</td>"
        + "<td style=\"font-weight:bold\">" +   rs3.getString("semanas")                        + "</td>"
        + "<td style=\"font-weight:bold\">" +   formatea.format(rs3.getInt("aves_carga") )   + "</td>"
        + "<td style=\"font-weight:bold\">" +   formatea.format(rs3.getInt("huevos_carga"))                      + "</td>"
        + "<td style=\"font-weight:bold\">                                                      </td>"
        + "<td style=\"font-weight:bold\">" +   rs3.getString("tipo")                           + "</td>"
        + "</tr>";
    }
   
        
        JSONObject DataScale= new JSONObject();
         
        JSONObject  contenidoData,          dataOptions,        data,
                    DataAves,               DataAvesPadron,     DataScaleAves, 
                    DataScalePadron,        ticksScalePadron,             DataPoint,
                    ticksScaleAves,         TitleScalePadron,              
                    TitleScaleAves,         PluginTitle,          ContenidoPoint,  annotation,line1,lineGlobal,label,  
                    Category                = new JSONObject();
      
        JSONArray   categories,             Dataset,            contenido_subcategorias, 
                    array_avesPadron,       array_aves, 
                    dataArray               = new JSONArray();         
    //////////////////////////////////////////AVES PADRON//////////////////////////////////////////////////////////////////////////////////                      
                    DataAvesPadron= new JSONObject();
                    DataAvesPadron.put("label",             "Aves padron");
                    DataAvesPadron.put("yAxisID",           "A");
                    DataAvesPadron.put("backgroundColor",   "rgb(196, 187, 187)");
                    DataAvesPadron.put("borderColor",       "rgb(132, 132, 132)");
                    DataAvesPadron.put("borderWidth",       2);
                    DataAvesPadron.put("pointRadius",       2);
                    DataAvesPadron.put("type",              "line");
                    DataAvesPadron.put("tension",           "0.4");
     
                    DataScalePadron= new JSONObject(); //PRINCIPAL PARA METER TODO LO RELACIONADO AL SCALE               
                    
                    TitleScalePadron= new JSONObject();                
                    TitleScalePadron.put("display",                   true);
                    TitleScalePadron.put("text",                      "Aves padron");
                    
                    DataScalePadron.put("title",                      TitleScalePadron); // DENTRO DE TITLE SE INSERTAN DISPLAY Y TEXT. VER ARRIBA.
                    
                    ticksScalePadron= new JSONObject(); 
                    ticksScalePadron.put("stepSize",                  25);
                    
                    DataScalePadron.put("ticks",                    ticksScalePadron);//EN DataScalePadron SE AGREGAN STEPSIZE. VER ARRIBA.
                    DataScalePadron.put("type",                       "linear");
                    DataScalePadron.put("display",                    true);
                    DataScalePadron.put("position",                   "right");
                    DataScalePadron.put("min",                        min-5000);
                    DataScalePadron.put("max",                        max);
    //////////////////////////////////////////AVES //////////////////////////////////////////////////////////////////////////////////                      
                    DataAves = new JSONObject();
                    DataAves.put("label",               "Aves");
                    DataAves.put("yAxisID",             "B");
                    DataAves.put("backgroundColor",     "rgb(209, 75, 75)");
                    DataAves.put("borderColor",         "rgb(186, 6, 6)");
                    DataAves.put("pointRadius",         2);
                    DataAves.put("borderWidth",         2);
                    DataAves.put("type",                "line");
                    DataAves.put("tension",           "0.4");
                     
                    DataScaleAves= new JSONObject();                
                    
                    TitleScaleAves= new JSONObject();          
                    TitleScaleAves.put("display",       true);
                    TitleScaleAves.put("text",          "");
                    
                    DataScaleAves.put("title",          TitleScaleAves);
                   
                    ticksScaleAves= new JSONObject(); 
                    ticksScaleAves.put("stepSize",      25);// NIVEL VERTICAL DE AVES.
                    
                    DataScaleAves.put("ticks",          ticksScaleAves);
                    DataScaleAves.put("type",           "linear");
                    DataScaleAves.put("display",        true);
                    DataScaleAves.put("position",       "right");
                    DataScaleAves.put("min",            min-5000);
                    DataScaleAves.put("max",            max);
                  ////////////////////////////////////////////////////////////////////////////  
                          
                    label= new JSONObject(); 
                    label.put("enabled",                true);
                   // label.put("content",                "CARGA PPR HASTA SEMANA "+ultima_carga_ppr);
                    
                    
                   
                    
                    ContenidoPoint= new JSONObject();
                    ContenidoPoint.put("radius",        0);
                    DataPoint= new JSONObject();
                    DataPoint.put("point",              ContenidoPoint);
                    contenido_subcategorias         = new JSONArray();
                    array_avesPadron                = new JSONArray();
                    array_aves                      = new JSONArray();
                   
                while(rs.next()) 
                { 
                    // este recorre la cantidad de registros que hay en ese mes y en ese aviario
                    contenido_subcategorias.put (   rs.getString("semanas")             );
                    array_aves.put              (   rs.getString("aves_carga")       );
                    array_avesPadron.put        (   rs.getString("aves_padron")   );
                    semana_barra        =           rs.getString("semana_barra");
                    ultima_carga_ppr    =           rs.getString("semana_lote_barra"); 
                } ////FIN DEL RECORRIDO LARGO
                 
                categories=new JSONArray();
                categories.put(Category);   
                
                DataAves.put(       "data",array_aves);  
                DataAvesPadron.put( "data",array_avesPadron);

                Dataset= new JSONArray();
                Dataset.put(DataAves);   
                Dataset.put(DataAvesPadron);   
                contenidoData= new JSONObject();
                data= new JSONObject(); 
                contenidoData.put("labels", contenido_subcategorias);
                contenidoData.put("datasets",    Dataset);
                contenidoData.put("datasetFill ",    false);
                contenidoData.put("lineAtIndex ",    30);
                
                
                DataScale.put(    "A",DataScaleAves);  
                DataScale.put(    "B",DataScalePadron);  
                data.put("data",contenidoData); 
                data.put("type",  "linear");
                
                
                 line1= new JSONObject(); 
                    line1.put("type",                   "line");
                    line1.put("xMin",                   ultima_carga_ppr);
                    line1.put("xMax",                   ultima_carga_ppr );
                    line1.put("label",                  label);
                    
                    line1.put("borderColor",            "rgb( 11, 137, 9 )");
                    line1.put("borderWidth",            3);
                    
                    lineGlobal= new JSONObject(); 
                    lineGlobal.put("line1",             line1);
            
                    annotation= new JSONObject();  
                    annotation.put("annotations",       lineGlobal);
                    
                    
                    
                    PluginTitle= new JSONObject();
                    PluginTitle.put("title",            TitleScaleAves); 
                    PluginTitle.put("annotation",       annotation); 
                 
                
                
                dataOptions= new JSONObject();   
                dataOptions.put("scales", DataScale);
                dataOptions.put("plugins", PluginTitle );
                dataOptions.put("elements", DataPoint);
                dataOptions.put("showAllTooltips", true);

                data.put("options",dataOptions);

                dataArray.put(data);
                
                
            String     cabecera = " <table id='tb_log' class='table-bordered compact hover dataTable ' style='width:100%; '  >"
                + "<thead>"

                 + "<tr>"
                + " <th  style='color: #fff; background: #00254d;' >Fecha de ajuste</th>      "
                + " <th  style='color: #fff; background: #00254d;' >Fecha de registro</th>      "
                + " <th  style='color: #fff; background: #00254d;' >Semana</th>      "
                + " <th  style='color: #fff; background: #00254d;' >Saldo nuevo</th>      "
                + " <th  style='color: #fff; background: #00254d;' >Ajuste</th>      "
                + " <th  style='color: #fff; background: #00254d;' >Usuario</th>      "
                + " <th  style='color: #fff; background: #00254d;' >Comentario</th>"
                    + "</tr>      "
                
                + " </thead> "
                + " <tbody >";
                
            cabecera2 = " <table id='tb_log_prod' class='table-bordered compact hover dataTable ' style='width:100%; '  >"
                + "<thead>"

                 + "<tr>"
                + " <th  style='color: #fff; background: #00254d;' >Fecha de ajuste</th>      "
                + " <th  style='color: #fff; background: #00254d;' >Fecha de registro</th>      "
                + " <th  style='color: #fff; background: #00254d;' >Semana</th>      "
                + " <th  style='color: #fff; background: #00254d;' >Aves</th>      "
                + " <th  style='color: #fff; background: #00254d;' >Productividad</th>      "
                + " <th  style='color: #fff; background: #00254d;' >Usuario</th>      "
                + " <th  style='color: #fff; background: #00254d;' >Comentario</th>"
                    + "</tr>      "
                
                + " </thead> "
                + " <tbody >";
            
           
                charts.put("charts", dataArray); 
                charts.put("grilla", cabecera + grilla_html + "</tbody></table>"); 
                charts.put("grilla_productividad", cabecera2 + grilla_html2 + "</tbody></table>"); 
                charts.put("subtitulo",  "CARGA PPR HASTA SEMANA "+ultima_carga_ppr); 
                charts.put("semana_barra",  semana_barra); 
                charts.put("id_lote",  id_lote ); 
                
                
    
      } catch (Exception e) {
        String error=e.getMessage();
      }
      finally{
      connection.close();
      out.print(charts);
    } 
 %>
 
 