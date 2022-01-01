package com.example.cinema_client.models;

import lombok.Data;

import java.util.List;

@Data
public class BookingRequestDTO {
    private Integer userId;
    private Integer scheduleId;
    private List<Integer> listSeatIds;
}
