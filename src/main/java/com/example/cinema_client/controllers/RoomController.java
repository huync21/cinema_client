package com.example.cinema_client.controllers;

import com.example.cinema_client.constants.Api;
import com.example.cinema_client.models.JwtResponseDTO;
import com.example.cinema_client.models.RoomDTO;
import com.example.cinema_client.models.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
@RequestMapping("/room-selection")
public class RoomController {
    @Autowired
    private RestTemplate restTemplate;

    public static String API_GET_ROOMS= Api.baseURL+"/api/rooms";

    @PostMapping
    public String displayRoomSelectionPage(HttpServletRequest request, Model model){
        HttpSession session = request.getSession();
        session.setAttribute("startDate",request.getParameter("startDate"));
        session.setAttribute("startTime",request.getParameter("startTime"));

        // Gắn access token jwt vào header để gửi kèm request
        HttpHeaders headers = new HttpHeaders();
        headers.set(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE);
        JwtResponseDTO jwtResponseDTO = (JwtResponseDTO)session.getAttribute("jwtResponse");
        headers.set(HttpHeaders.AUTHORIZATION,"Bearer "+jwtResponseDTO.getAccessToken());
        HttpEntity<?> entity = new HttpEntity<>(headers);

        String urlTemplate = UriComponentsBuilder.fromHttpUrl(API_GET_ROOMS)
                .queryParam("movieId", "{movieId}")
                .queryParam("branchId","{branchId}")
                .queryParam("startDate","{startDate}")
                .queryParam("startTime","{startTime}")
                .encode()
                .toUriString();
        Map<String,String> listRequestParam = new HashMap<>();
        listRequestParam.put("movieId", session.getAttribute("movieId")+"");
        listRequestParam.put("branchId",session.getAttribute("branchId")+"");
        listRequestParam.put("startDate", LocalDate.parse(request.getParameter("startDate")).format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        listRequestParam.put("startTime", LocalTime.parse(request.getParameter("startTime")).format(DateTimeFormatter.ofPattern("HH:mm")));
        ResponseEntity<RoomDTO[]> listRooms = restTemplate.exchange(urlTemplate,
                HttpMethod.GET,entity,RoomDTO[].class,listRequestParam);


        model.addAttribute("listRooms",listRooms.getBody());
        model.addAttribute("user",new User());
        session.removeAttribute("bookedError");
;        return "room";
    }
}
