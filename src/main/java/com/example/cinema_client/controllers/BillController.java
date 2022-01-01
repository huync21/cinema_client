package com.example.cinema_client.controllers;

import com.example.cinema_client.models.ScheduleDTO;
import com.example.cinema_client.models.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;


@Controller
@RequestMapping("/bill")
public class BillController {
    @Autowired
    private RestTemplate restTemplate;

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
        return "bill";
    }
}
