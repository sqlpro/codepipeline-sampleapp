package com.shinhan.memberapp;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;

@RestController
public class HomeController {
    @GetMapping("/")
    public String index() {
        return "SUCCESS WITH NEW DEPLOPU: " + new Date();
    }
}
