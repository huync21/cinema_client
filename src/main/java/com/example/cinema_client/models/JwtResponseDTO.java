package com.example.cinema_client.models;

import lombok.Data;

import java.util.List;

@Data
public class JwtResponseDTO {
    private Integer id;
    private String username;
    private String name;
    private String accessToken;
    private String tokenType;
}
