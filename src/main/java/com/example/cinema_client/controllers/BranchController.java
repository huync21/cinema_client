package com.example.cinema_client.controllers;

import com.example.cinema_client.models.BranchDTO;
import com.example.cinema_client.models.JwtResponseDTO;
import com.example.cinema_client.models.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/branches")
public class BranchController {
    @Autowired
    private RestTemplate restTemplate;

    public static String apiGetBranches = "http://localhost:8080/api/branches";

    @GetMapping
    public String displayBranchesPage(@RequestParam Integer movieId, Model model, HttpServletRequest request){
        HttpHeaders headers = new HttpHeaders();
        headers.set(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE);
        JwtResponseDTO jwtResponseDTO = (JwtResponseDTO)request.getSession().getAttribute("jwtResponse");
        headers.set(HttpHeaders.AUTHORIZATION,"Bearer "+jwtResponseDTO.getAccessToken());
        HttpEntity<?> entity = new HttpEntity<>(headers);

        String urlTemplate = UriComponentsBuilder.fromHttpUrl(apiGetBranches)
                .queryParam("movieId", "{movieId}")
                .encode()
                .toUriString();

        Map<String, Integer> params = new HashMap<>();
        params.put("movieId", movieId);


        HttpEntity<BranchDTO[]> response = restTemplate.exchange(
                urlTemplate,
                HttpMethod.GET,
                entity,
                BranchDTO[].class,
                params
        );
        BranchDTO[] branchDTOS = response.getBody();
        model.addAttribute("branches",branchDTOS);
        model.addAttribute("user",new User());
        return "branches";

    }
}
