package com.example.cinema_client.controllers;

import com.example.cinema_client.models.MovieDTO;
import com.example.cinema_client.models.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@Controller
@RequestMapping("/")
public class HomeController {
    @Autowired
    private RestTemplate restTemplate;

    public static String apiGetShowingMovies = "http://localhost:8080/api/movies/showing";

    @GetMapping
    public String displayHomePage(Model model){
        ResponseEntity<MovieDTO[]> response = restTemplate.getForEntity(apiGetShowingMovies,MovieDTO[].class);
        MovieDTO[] movies = response.getBody();
        model.addAttribute("movies",movies);
        model.addAttribute("user",new User());

        return "home";
    }
}
