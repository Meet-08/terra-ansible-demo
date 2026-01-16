package com.meet.terraansibledemo;

import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.Arrays;

@RestController
public class TestController {

    private final Environment environment;

    public TestController(Environment environment) {
        this.environment = environment;
    }

    @GetMapping("/test")
    public String testEndpoint() {
        String hostname = System.getenv("HOSTNAME") != null ? System.getenv("HOSTNAME") : "localhost";
        String activeProfiles = Arrays.toString(environment.getActiveProfiles());
        String port = environment.getProperty("local.server.port", "8080");

        return """
                <html>
                <body style="font-family: sans-serif; line-height: 1.6; padding: 20px;">
                    <h1 style="color: #2e7d32;">🚀 Spring Boot Application is Running!</h1>
                    <hr>
                    <p><strong>Status:</strong> Up and Running</p>
                    <p><strong>Timestamp:</strong> %s</p>
                    <p><strong>Hostname:</strong> <code style="background: #eee; padding: 2-4px;">%s</code></p>
                    <p><strong>Active Profiles:</strong> %s</p>
                    <p><strong>Port:</strong> %s</p>
                </body>
                </html>
                """.formatted(LocalDateTime.now(), hostname, activeProfiles, port);
    }
}