<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <style type="text/css">
        th {
            padding: 0px 20px 5px 0px;
        }
    </style>
</head>

<body>
<!-- nav bar -->
<jsp:include page="header.jsp"/>
<!-- end of navbar -->

<br><br><br>
<div class="container">
    <h1>Chi Tiết Phim</h1>
    <br>
    <div style="display:flex">
        <div style="margin-right:50px">
            <img src="${movie.smallImageURl}" alt="">
            <%--Nếu chưa đăng nhập mà đã click vào nút mua vé thì trả về trang có nút có class btn-buy-ticket-not-signed-in để
                        toggle cái form đăng nhập--%>
            <c:choose>
                <c:when test="${sessionScope.jwtResponse eq null}">
                    <button  class="btn btn-danger btn-block btn-buy-ticket-not-signed-in">Mua vé</button>
                </c:when>
                <c:otherwise>
                    <a href="branches?movieId=${movie.id}" class="btn btn-danger btn-block">Mua Vé</a>
                </c:otherwise>
            </c:choose>
        </div>
        <table>
            <tr>
                <th><b>Tên Phim: </b></th>
                <th>${movie.name}</th>
            </tr>
            <tr>
                <th><b>Đạo diễn:</b></th>
                <th>${movie.director}</th>
            </tr>
            <tr>
                <th><b>Diễn Viên:</b></th>
                <th>${movie.actors}</th>
            </tr>
            <tr>
                <th><b>Ngày Khởi Chiếu:</b></th>
                <th>${movie.releaseDate}</th>
            </tr>
            <tr>
                <th><b>Thể Loại:</b></th>
                <th>${movie.categories}</th>
            </tr>
            <tr>
                <th><b>Thời Lượng:</b></th>
                <th>${movie.duration} phút</th>
            </tr>
            <tr>
                <th><b>Ngôn Ngữ:</b></th>
                <th>${movie.language}</th>
            </tr>
            <tr>
                <th><b>Rated:</b></th>
                <th>${movie.rated}</th>
            </tr>

        </table>


    </div>
    <br>
    <br>
    <div style="display:flex;">
        <div style="margin-right: 50px">
            <h1>Trailer:</h1>
            <iframe width="560" height="315" src="${movie.trailerURL}"
                    title="YouTube video player" frameborder="0"
                    allow="accelerometer; autoplay; clipboard-write; gyroscope; picture-in-picture"
                    allowfullscreen>
            </iframe>
        </div>
        <div>
            <h1>Giới Thiệu:</h1>
            <p>${movie.longDescription}</p>
        </div>
    </div>
    <br>

    <br>
    <br>
</div>
<br>
<br>
<jsp:include page="footer.jsp"/>

<%--Nếu chưa đăng nhập mà đã click vào nút mua vé thì trả về trang có function để
toggle cái form đăng nhập--%>
<c:choose>
    <c:when test="${sessionScope.jwtResponse eq null}">
        <script>
            $(document).ready(function() {
                $('.btn-buy-ticket-not-signed-in').on('click', function () {
                    $('#modalLoginForm').modal('show');
                })
                // $('#close').on('click',function(){
                //     $('#modalLoginForm').modal({ show: false});
                // })
            })
        </script>
    </c:when>
    <c:otherwise>

    </c:otherwise>
</c:choose>
</body>

</html>