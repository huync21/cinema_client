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
                    <a href="#" class="btn btn-outline-warning" style="margin-right:70px">Chi tiết</a>
                    <a href="branch_selection.html" class="btn btn-outline-danger">Mua vé</a>
                </div>
            </div>
        </c:forEach>



    </div>
</div>
</div>
<!-- end of movie selections -->


</body>

</html>