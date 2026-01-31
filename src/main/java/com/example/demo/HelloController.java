package com.example.demo;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class HelloController {

    @Value("${CLOUD_PROVIDER:Unknown}")
    private String cloudProvider;

    @GetMapping("/")
    public String root() {
        return "OK";
    }

    @GetMapping("/hello")
    public String hello() {
        return "Hello from " + cloudProvider + "!";
    }

    @GetMapping("/health")
    public String health() {
        return "{\"status\":\"UP\",\"provider\":\"" + cloudProvider + "\"}";
    }
}
