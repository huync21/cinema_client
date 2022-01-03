<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css" integrity="sha512-1PKOgIY59xJ8Co8+NE6FZ+LOAZKjy+KY8iq0G4B3CyeY6wYHN3yt9PW0XpSriVlkMXe40PTKnXrLnZ9+fkDaog==" crossorigin="anonymous" />
</head>
<!-- nav bar -->
<nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
    <a class="navbar-brand" href="/">HUYCINEMA</a>

    <div class="collapse navbar-collapse" id="navb">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="/">Trang chủ</a>
            </li>
            <c:choose>
                <c:when test="${sessionScope.jwtResponse eq null}">

                </c:when>
                <c:otherwise>
                    <li class="nav-item">
                        <a class="nav-link" href="/tickets/history">Lịch sử mua vé</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Cá nhân</a>
                    </li>
                </c:otherwise>
            </c:choose>

            <li class="nav-item">
                <a class="nav-link" href="/">Liên hệ</a>
            </li>
        </ul>
        <div class="form-inline my-2 my-lg-0">
            <c:choose>
                <c:when test="${sessionScope.jwtResponse eq null}">
                    <li class="nav-item">
                        <a href="" class="btn btn-primary" data-toggle="modal" data-target="#modalLoginForm">Đăng
                            nhập</a>
                    </li>
                    <li class="nav-item">
                        <a href="" class="btn btn-info" data-toggle="modal" data-target="#modalRegisterForm">Đăng ký</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item">
                        <a style="color: gold">${sessionScope.jwtResponse.name}</a>
                    </li>
                    <li class="nav-item">
                        <a href="/account/sign-out" class="btn btn-danger">Đăng xuất</a>
                    </li>
                </c:otherwise>
            </c:choose>


        </div>
    </div>
</nav>
<body>
<!-- login modal -->
<div class="modal fade" id="modalLoginForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="/account/login" method="post">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold">Đăng nhập</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body mx-3">
                    <c:choose>
                        <c:when test="${loginError eq null}">

                        </c:when>
                        <c:otherwise>
                            <p style="color: red"><i>${loginError}</i></p>
                            <br>
                        </c:otherwise>
                    </c:choose>
                    <div class="md-form mb-5">
                        <label data-error="wrong" data-success="right" for="defaultForm-email">Email</label>
                        <i class="fas fa-envelope prefix grey-text"></i>
                        <input name="username" type="text" id="defaultForm-email" class="form-control validate"
                               value="${un}"/>
                    </div>

                    <div class="md-form mb-4">
                        <label data-error="wrong" data-success="right" for="defaultForm-pass">Mật khẩu</label>
                        <i class="fas fa-lock prefix grey-text"></i>
                        <input name="password" type="password" id="defaultForm-pass" class="form-control validate"
                               value="${pw}"/>
                    </div>
                </div>
                <div class="modal-header d-flex justify-content-center">
                    <button type="submit" class="btn btn-primary btn-block" >Đăng Nhập</button>
                </div>
            </form>
            <div class=" d-flex justify-content-center">
                Chưa có tải khoản?
            </div>
            <div class="modal-header d-flex justify-content-center">
                <button id="btn-register" class="btn btn-info btn-block">Đăng Ký</button>
            </div>
        </div>
    </div>
</div>

<div class="text-center">

</div>
<!-- end of login modal -->

<!-- sign up modal -->
<div class="modal fade" id="modalRegisterForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form:form action="/account/register" method="post" modelAttribute="user">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold">Đăng ký</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3">
                    <div class="md-form mb-5">
                        <p><i style="color: red">${registerError}</i></p>
                        <label data-error="wrong" data-success="right" for="orangeForm-name">Họ tên</label>
                        <i class="fas fa-user prefix grey-text"></i>
                        <form:input path="fullName" name="fullname" type="text" id="orangeForm-name"
                                    class="form-control validate" value="${fn}"/>
                        <form:errors path="fullName" cssClass="error" cssStyle="color: red"/>
                    </div>
                    <div class="md-form mb-5">
                        <label data-error="wrong" data-success="right" for="orangeForm-email">Email</label>
                        <i class="fas fa-envelope prefix grey-text"></i>
                        <form:input path="username" name="username" type="text" id="orangeForm-email"
                                    class="form-control validate" value="${un}"/>
                        <form:errors path="username" cssClass="error" cssStyle="color: red"/>
                    </div>

                    <div class="md-form mb-4">
                        <label data-error="wrong" data-success="right" for="orangeForm-pass">Mật khẩu</label>
                        <i class="fas fa-lock prefix grey-text"></i>
                        <form:input path="password" name="password" type="password" id="orangeForm-pass"
                                    class="form-control validate" value="${pw}"></form:input>
                        <form:errors path="password" cssClass="error" cssStyle="color: red"/>
                    </div>

                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <form:button class="btn btn-primary btn-block">Đăng ký</form:button>
                </div>
            </form:form>
        </div>
    </div>
</div>
<!-- end of sign up modal -->

<script>
    $("#btn-register").on('click', function () {
        $("#modalLoginForm").modal("hide")
        $(".modal-backdrop").css("display","none")
        $("#modalRegisterForm").modal("show")
    })
</script>
</body>