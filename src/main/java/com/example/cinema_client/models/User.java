package com.example.cinema_client.models;
import lombok.Data;

import java.util.Set;


@Data
public class User {
    private String username;
    private String password;
    private String fullName;
    private Set<Role> roles;
}