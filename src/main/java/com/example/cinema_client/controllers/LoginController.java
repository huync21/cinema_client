package com.example.cinema_client.controllers;

import com.example.cinema_client.models.JwtResponseDTO;
import com.example.cinema_client.models.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/account")
public class LoginController {
    @Autowired
    private RestTemplate restTemplate;

    public static String apiLogin = "http://localhost:8080/login";

    @PostMapping("/login")
    public String login(@ModelAttribute("user")User user, HttpServletRequest request){
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<User> httpEntity = new HttpEntity<>(user,httpHeaders);
        ResponseEntity<JwtResponseDTO> jwtResponse
                = restTemplate.exchange(apiLogin, HttpMethod.POST,httpEntity, JwtResponseDTO.class);

        request.getSession().setAttribute("jwtResponse",(JwtResponseDTO)jwtResponse.getBody());
        return "redirect:/";
    }

    @GetMapping("/sign-out")
    public String signOut(HttpServletRequest request){
        request.getSession().removeAttribute("jwtResponse");
        return "redirect:/";
    }
}
