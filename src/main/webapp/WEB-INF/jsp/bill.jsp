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
        <h2>Thanh toán hóa đơn</h2>
        <br>
        <div style="display:flex">
            <table>
                <tr>
                    <th><b>Tên Phim: </b></th>
                    <th>${sessionScope.schedule.movie.name}</th>
                </tr>
                <tr>
                    <th><b>Tên Chi Nhánh:</b></th>
                    <th>${sessionScope.schedule.branch.name}</th>
                </tr>
                <tr>
                    <th><b>Giờ Chiếu:</b></th>
                    <th>${sessionScope.schedule.startTime}</th>
                </tr>
                <tr>
                    <th><b>Ngày Chiếu:</b></th>
                    <th>${formattedDate}</th>
                </tr>
                <tr>
                    <th><b>Tên Phòng:</b></th>
                    <th>${sessionScope.schedule.room.name}</th>
                </tr>
                <tr>
                    <th><b>Số Vé:</b></th>
                    <th>${numberOfSelectedSeats}</th>
                </tr>
                <tr>
                    <th><b>Tiền Vé Đơn:</b></th>
                    <th>${sessionScope.schedule.price}</th>
                </tr>
                <tr>
                    <th><b>Tổng:</b></th>
                    <th>${totalAmount}</th>
                </tr>
            </table>
            <div style="margin-left:50px">
                <img src="${sessionScope.schedule.movie.smallImageURl}" alt="">
            </div>
            <div style="margin-left:50px; height: 300px;">
                <img style="height: 100%;" src="${sessionScope.schedule.branch.imgURL}" alt="">
            </div>
        </div>
        <br>
        <a href="bill" class="btn btn-outline-danger btn-block">Thanh Toán</a>
</div>
<br>
<br>
<br>
<jsp:include page="footer.jsp"/>
</body>

</html>