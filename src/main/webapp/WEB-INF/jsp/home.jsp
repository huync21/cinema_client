<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
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

    <style>
        /* carousel */
        /* Make the image fully responsive */
        .carousel-inner img {
            width: 100%;
            height: 100%;
        }
        .img-movie {
            height: 400px;
        }
        .movie-item {
            margin-bottom: 50px;
        }
    </style>
    <title>Trang chủ</title>
</head>

<body>

<!-- content -->
<div class="container">
    <%--    navbar--%>
    <jsp:include page="header.jsp"/>

    <!-- carousel -->
    <br>
    <br>
    <br>
    <h1>Phim Mới Chiếu</h1>
    <div id="demo" class="carousel slide" data-ride="carousel">

        <!-- Indicators -->
        <ul class="carousel-indicators">
            <li data-target="#demo" data-slide-to="0" class="active"></li>
            <li data-target="#demo" data-slide-to="1"></li>
            <li data-target="#demo" data-slide-to="2"></li>
            <li data-target="#demo" data-slide-to="3"></li>
            <li data-target="#demo" data-slide-to="4"></li>
        </ul>

        <!-- The slideshow -->
        <div class="carousel-inner">
            <c:forEach items="${movies}" var="movie" varStatus="count">
                <c:choose>
                    <c:when test = "${count.index eq 0}">
                        <div class="carousel-item active">
                            <img src="${movie.largeImageURL}"
                                 alt="Los Angeles" width="1100" height="500">
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="carousel-item">
                            <img src="${movie.largeImageURL}"
                                 alt="Los Angeles" width="1100" height="500">
                        </div>
                    </c:otherwise>
                </c:choose>


            </c:forEach>
        </div>

        <!-- Left and right controls -->
        <a class="carousel-control-prev" href="#demo" data-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </a>
        <a class="carousel-control-next" href="#demo" data-slide="next">
            <span class="carousel-control-next-icon"></span>
        </a>
    </div>
    <!-- end of carousel -->

    <!-- movie selections-->
    <br>
    <br>
    <h2>Chọn Phim</h2>
    <div class="d-flex justify-content-between flex-wrap">
        <c:forEach items = "${movies}" var="movie">
            <div class="card movie-item" style="width:300px">
                <img class="card-img-top img-movie"
                     src="${movie.smallImageURl}"
                     alt="Card image" style="width:100%">
                <div class="card-body">
                    <h4 class="card-title">${movie.name}</h4>
                    <p class="card-text">${movie.shortDescription}</p>
                    <a href="/movie-details?movieId=${movie.id}" class="btn btn-outline-warning" style="margin-right:70px">Chi tiết</a>

                        <%--Nếu chưa đăng nhập mà đã click vào nút mua vé thì trả về trang có nút có class btn-buy-ticket-not-signed-in để
                        toggle cái form đăng nhập--%>
                    <c:choose>
                        <c:when test="${sessionScope.jwtResponse eq null}">
                            <button  class="btn btn-outline-danger btn-buy-ticket-not-signed-in">Mua vé</button>
                        </c:when>
                        <c:otherwise>
                            <a href="/branches?movieId=${movie.id}" class="btn btn-outline-danger" >Mua vé</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:forEach>



    </div>
        <!-- end of movie selections -->
</div>
</div>

<%--Nếu chưa đăng nhập mà đã click vào nút mua vé thì trả về trang có function toggle cái form đăng nhập--%>
<c:choose>
    <c:when test="${sessionScope.jwtResponse eq null}">
        <script>
            $(document).ready(function() {
                $('.btn-buy-ticket-not-signed-in').on('click', function () {
                    $('#modalLoginForm').modal('show');
                })
                // $('.close').on('click',function(){
                //     $('#modalLoginForm').modal({ show: false});
                //     // clear input fields
                //     $('#defaultForm-email').html("")
                //     $('#defaultForm-pass').html("")
                //     $('#orangeForm-name').html("")
                //     $('#orangeForm-email').html("")
                //     $('#orangeForm-password').html("")
                // })
            })
        </script>
    </c:when>
    <c:otherwise>

    </c:otherwise>
</c:choose>

<%--Nếu có lỗi đăng ký thì hiện cái form modal đăng ký ra--%>
<c:choose>
    <c:when test="${hasErrors eq null}">

    </c:when>
    <c:otherwise>
        <script>
                $(window).on('load',function() {
                    $('#modalRegisterForm').modal('show');
                });
        </script>
    </c:otherwise>
</c:choose>

<%-- Nếu có lỗi đăng nhập thì hiện form modal đăng nhập ra--%>
<c:choose>
    <c:when test="${hasLoginErrors eq null}">

    </c:when>
    <c:otherwise>
        <script>
            $(window).on('load',function() {
                $('#modalLoginForm').modal('show');
            });
        </script>
    </c:otherwise>
</c:choose>

<br>
<br>
<jsp:include page="footer.jsp"/>
</body>

</html>