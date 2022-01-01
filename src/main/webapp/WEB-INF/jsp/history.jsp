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
        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
        }
        td{
            text-align:center
        }
    </style>
</head>

<body>
<!-- nav bar -->
<jsp:include page="header.jsp"/>
<!-- end of navbar -->

<br><br><br>
<div class="container-fluid">
    <h2>Lịch Sử Mua Vé </h2>
    <br>
    <div>
        <table style="width:100%">
            <tr>
                <th>Tên Phim</th>
                <th>Tên Chi Nhánh</th>
                <th>Giờ Chiếu</th>
                <th>Tên Phòng</th>
                <th>Ghế</th>
                <th>Giờ Mua</th>
                <th>Mã QR</th>
            </tr>
            <c:forEach items="${listTickets}" var="ticket">
                <tr>
                    <td >${ticket.schedule.movie.name}</td>
                    <td>${ticket.schedule.branch.name}</td>
                    <td>${ticket.schedule.startTime} ${ticket.schedule.startDate}</td>
                    <td>${ticket.schedule.room.name}</td>
                    <td>${ticket.seat.name}</td>
                    <td>${ticket.bill.createdTime}</td>
                    <td><img src="${ticket.qrImageURL}"></td>
                </tr>
            </c:forEach>


        </table>

    </div>
    <br>
</div>
<br>
<br>
<jsp:include page="footer.jsp"/>
</body>

</html>