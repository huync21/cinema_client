package com.example.cinema_client;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.web.util.UriComponentsBuilder;

@SpringBootTest
class CinemaClientApplicationTests {

    @Test
    void contextLoads() {
        System.out.println(UriComponentsBuilder.fromHttpUrl("http://localhost:8080/api/branches")
                .queryParam("movieId","{movieId}").encode().toUriString());
    }

}
