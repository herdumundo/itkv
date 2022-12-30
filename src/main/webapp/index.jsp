 <%@ page session="true" %>
<%@ page language="java" import="java.sql.*" %>
  <!DOCTYPE html>
 

<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>ITKV</title>


   <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
  <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
  <link rel="stylesheet" href="dist/css/adminlte.min.css">
</head>
<body class="hold-transition login-page">
<div class="login-box">
  <!-- /.login-logo -->
  <div class="card card-outline card-danger">
    <div class="card-header text-center">
  <img src="img//ITKV.png" width="300" height="150" alt=""/>      
     </div>
    <div class="card-body">
        <p class="login-box-msg" ><strong>Inicio de sesi�n</strong></p>

        <form action="cruds/control_login.jsp" method="post">
        
          <div class="input-group mb-3">
              <input type="text" name="usuario" class="form-control" placeholder="Usuario" required>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-user"></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
            <input type="password" name="pass"class="form-control" placeholder="Contrase�a" required>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-8">
            <div class="icheck-primary">
              <input type="checkbox" id="remember">
             
            </div>
          </div>
          <!-- /.col -->
          <div class="col-4">
              <button type="submit" class="btn bg-navy btn-block" >Ingresar</button>
          </div>
          <!-- /.col -->
        </div>
      </form>

      
       
    </div>
     </div>
  <!-- /.card -->
</div>
 
      
                             
<!-- /.login-box -->

<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="dist/js/adminlte.min.js"></script>
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="plugins/sweetalert2/sweetalert2.all.min.js" type="text/javascript"></script>
 </body>
</html>
         