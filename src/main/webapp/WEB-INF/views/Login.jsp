<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="css/bootstrap-theme.min.css">
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-4 col-sm-offset-4">
				<div class="panel panel-default" style="margin-top: 30%">
					<div class="panel-heading">
						<h3 class="panel-title">Login</h3>
					</div>
					<div class="panel-body">
						<form action="loginOneUser" method="post" class="form-horizontal">
							<div class="form-group">
								<label for="username" class="col-sm-4 control-label">User
									Name:</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" name="username"
										value="">
								</div>
							</div>
							<div class="form-group">
								<label for="password" class="col-sm-4 control-label">Password:</label>
								<div class="col-sm-8">
									<input type="password" class="form-control" name="password"
										value="">
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-offset-4">
									<button type="submit" class="btn btn-primary">Submit</button>
									<button type="reset" class="btn btn-default">Reset</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>