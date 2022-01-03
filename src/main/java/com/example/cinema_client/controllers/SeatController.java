package com.example.cinema_client.controllers;

import com.example.cinema_client.constants.Api;
import com.example.cinema_client.models.JwtResponseDTO;
import com.example.cinema_client.models.ScheduleDTO;
import com.example.cinema_client.models.SeatDTO;
import com.example.cinema_client.models.User;
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
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/seat-selection")
public class SeatController {
    @Autowired
    private RestTemplate restTemplate;

    public static String API_GET_SCHEDULE=Api.baseURL+"/api/schedule";
    public static String API_GET_SEATS= Api.baseURL+"/api/seats";

    @GetMapping
    public String displaySeatSelectionPage(@RequestParam Integer movieId, @RequestParam Integer branchId, @RequestParam String startDate,
                                           @RequestParam String startTime, @RequestParam Integer roomId, HttpServletRequest request,
                                           Model model){
        HttpSession session = request.getSession();
        session.setAttribute("roomId",roomId);

        // Gắn access token jwt vào header để gửi kèm request
        HttpHeaders headers = new HttpHeaders();
        headers.set(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE);
        JwtResponseDTO jwtResponseDTO = (JwtResponseDTO)session.getAttribute("jwtResponse");
        headers.set(HttpHeaders.AUTHORIZATION,"Bearer "+jwtResponseDTO.getAccessToken());
        HttpEntity<?> entity = new HttpEntity<>(headers);

        // Gọi api lấy ra lịch được chọn
        String urlTemplate = UriComponentsBuilder.fromHttpUrl(API_GET_SCHEDULE)
                .queryParam("movieId", "{movieId}")
                .queryParam("branchId","{branchId}")
                .queryParam("startDate","{startDate}")
                .queryParam("startTime","{startTime}")
                .queryParam("roomId","{roomId}")
                .encode()
                .toUriString();
        Map<String,String> listRequestParam = new HashMap<>();
        listRequestParam.put("movieId", movieId+"");
        listRequestParam.put("branchId",branchId+"");
        listRequestParam.put("startDate", LocalDate.parse(startDate).format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        listRequestParam.put("startTime", LocalTime.parse(startTime).format(DateTimeFormatter.ofPattern("HH:mm")));
        listRequestParam.put("roomId",roomId+"");
        ResponseEntity<ScheduleDTO[]> listScheduleDTOResponse = restTemplate.exchange(urlTemplate,
                HttpMethod.GET,entity,ScheduleDTO[].class,listRequestParam);

        ScheduleDTO scheduleDTO =  listScheduleDTOResponse.getBody()[0];
        //Lưu scheduleDTO lên session tí thanh toán còn hiện thông tin ra:
        session.setAttribute("schedule",scheduleDTO);

        //Gọi api lấy ra những ghế ngồi của lịch đó
        String urlTemplate1 = UriComponentsBuilder.fromHttpUrl(API_GET_SEATS)
                .queryParam("scheduleId", "{scheduleId}")
                .encode()
                .toUriString();
        Map<String,String> listRequestParam1 = new HashMap<>();
        listRequestParam1.put("scheduleId", scheduleDTO.getId()+"");
        ResponseEntity<SeatDTO[]> listSeatDTOResponse = restTemplate.exchange(urlTemplate1,
                HttpMethod.GET,entity,SeatDTO[].class,listRequestParam1);

        SeatDTO[] listSeatDTOS = (SeatDTO[]) listSeatDTOResponse.getBody();
        SeatDTO[] listA = new SeatDTO[8];
        SeatDTO[] listB = new SeatDTO[8];
        SeatDTO[] listC = new SeatDTO[8];
        SeatDTO[] listD = new SeatDTO[8];
        SeatDTO[] listE = new SeatDTO[8];
        for(int i=0;i<=7;i++){
            listA[i]=listSeatDTOS[i];
            listB[i]=listSeatDTOS[i+8];
            listC[i]=listSeatDTOS[i+16];
            listD[i]=listSeatDTOS[i+24];
            listE[i]=listSeatDTOS[i+32];
        }
        model.addAttribute("listA",listA);
        model.addAttribute("listB",listB);
        model.addAttribute("listC",listC);
        model.addAttribute("listD",listD);
        model.addAttribute("listE",listE);
        model.addAttribute("user",new User());

        return "seats";
    }
}
