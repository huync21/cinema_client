package com.example.cinema_client.controllers;

import com.example.cinema_client.constants.Api;
import com.example.cinema_client.models.JwtResponseDTO;
import com.example.cinema_client.models.User;
import org.apache.tomcat.jni.Local;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {
    @Autowired
    private RestTemplate restTemplate;

    public static String API_GET_START_TIMES = Api.baseURL+"/api/schedule/start-times";

    @GetMapping
    public String displaySchedulePage(@RequestParam Integer movieId,@RequestParam Integer branchId, Model model, HttpServletRequest request){
        HttpSession session = request.getSession();
        session.setAttribute("branchId",branchId);

        // Gắn access token jwt vào header để gửi kèm request
        HttpHeaders headers = new HttpHeaders();
        headers.set(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE);
        JwtResponseDTO jwtResponseDTO = (JwtResponseDTO)session.getAttribute("jwtResponse");
        headers.set(HttpHeaders.AUTHORIZATION,"Bearer "+jwtResponseDTO.getAccessToken());
        HttpEntity<?> entity = new HttpEntity<>(headers);

        // Để tạm ngày hôm nay là 30/12
        LocalDate today = LocalDate.parse("2021-01-05");
        ArrayList<LocalDate> listDates = new ArrayList<>();
        listDates.add(today);
        // Lấy ra 10 ngày tính từ hôm nay
        for(int i=1;i<=9;i++){
            today = today.plusDays(1);
            listDates.add(today);
        }

        //Lấy ra những thời điểm bắt đầu tính từ hôm nay:
        String urlTemplate = UriComponentsBuilder.fromHttpUrl(API_GET_START_TIMES)
                .queryParam("movieId", "{movieId}")
                .queryParam("branchId","{branchId}")
                .queryParam("startDate","{startDate}")
                .encode()
                .toUriString();
        Map<String,String> listRequestParam = new HashMap<>();
        listRequestParam.put("movieId", movieId+"");
        listRequestParam.put("branchId",branchId+"");
        listRequestParam.put("startDate",LocalDate.parse("2021-01-05").format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));

        ResponseEntity<String[]> listStartTimesEntity = restTemplate.exchange(urlTemplate,
                HttpMethod.GET,entity,String[].class,listRequestParam);

        model.addAttribute("listDates",listDates);
        model.addAttribute("listStartTimes",listStartTimesEntity.getBody());
        model.addAttribute("user",new User());
        return "schedule";
    }
}
