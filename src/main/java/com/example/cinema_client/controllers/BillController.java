package com.example.cinema_client.controllers;

import com.example.cinema_client.constants.Api;
import com.example.cinema_client.models.BookingRequestDTO;
import com.example.cinema_client.models.JwtResponseDTO;
import com.example.cinema_client.models.ScheduleDTO;
import com.example.cinema_client.models.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;


@Controller
@RequestMapping("/bill")
public class BillController {
    @Autowired
    private RestTemplate restTemplate;
    public static String API_CREATE_BILL= Api.baseURL+"/api/bills/create-new-bill";

    @PostMapping
    public String displayBillPage(HttpServletRequest request, Model model){
        HttpSession session = request.getSession();
        //Lấy ra những chỗ ngồi mà khách đặt,map sang list kiểu int rồi lưu lên session
        String[] seats = request.getParameterValues("seats");
        List<Integer> listSeatIds = Arrays.stream(seats).map(seat->Integer.parseInt(seat)).collect(Collectors.toList());
        session.setAttribute("listSelectedSeatIds",listSeatIds);

        // Đếm số ghế:
        Integer numberOfSelectedSeats= listSeatIds.size();
        model.addAttribute("numberOfSelectedSeats",numberOfSelectedSeats);

        // Lấy ra tổng tiền:
        ScheduleDTO scheduleFromSession = (ScheduleDTO)session.getAttribute("schedule");
        Double totalAmount = scheduleFromSession.getPrice() * numberOfSelectedSeats;
        model.addAttribute("totalAmount",totalAmount);

        // Format laại ngày:
        model.addAttribute("formattedDate",
                scheduleFromSession.getStartDate().format(DateTimeFormatter.ofPattern("dd-MM-yyyy")));

        model.addAttribute("user",new User());
        session.removeAttribute("bookedError");
        return "bill";
    }

    @GetMapping
    public String createBill(HttpServletRequest request,Model model){
        HttpSession session = request.getSession();

        // Gắn access token jwt vào header để gửi kèm request
        HttpHeaders headers = new HttpHeaders();
        headers.set(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE);
        JwtResponseDTO jwtResponseDTO = (JwtResponseDTO)session.getAttribute("jwtResponse");
        headers.set(HttpHeaders.AUTHORIZATION,"Bearer "+jwtResponseDTO.getAccessToken());


        // Đóng gói user id. schedule id và list id các ghế vào request gửi đi
        BookingRequestDTO body = new BookingRequestDTO();
        body.setUserId(jwtResponseDTO.getId());
        ScheduleDTO scheduleFromSession = (ScheduleDTO)session.getAttribute("schedule");
        body.setScheduleId(scheduleFromSession.getId());
        List<Integer> listSeatIds = (List<Integer>)session.getAttribute("listSelectedSeatIds");
        body.setListSeatIds(listSeatIds);
        model.addAttribute("user",new User());


        String message = "Có người nhanh tay hơn đã chọn vào ghế mà bạn đã đặt, vui lòng chọn lại chỗ ngồi!";
        try {
            HttpEntity<?> entity = new HttpEntity<>(body, headers);
            ResponseEntity<String> response = restTemplate.exchange(API_CREATE_BILL, HttpMethod.POST, entity, String.class);
        }catch (HttpClientErrorException ex){ // Nếu đã có người đặt ghế nhanh hơn thì quay lại trang chọn ghế
                 message = ex.getResponseBodyAsString();
                session.setAttribute("bookedError",message);
                return "redirect:/seat-selection?movieId="+scheduleFromSession.getMovie().getId()+
                        "&branchId=+"+scheduleFromSession.getBranch().getId()+"&startDate="+
                        scheduleFromSession.getStartDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))+"&startTime="+
                        scheduleFromSession.getStartTime().format(DateTimeFormatter.ofPattern("HH:mm"))+"&roomId="+
                        scheduleFromSession.getRoom().getId();

        }


        return "redirect:/tickets/history";
    }
}
