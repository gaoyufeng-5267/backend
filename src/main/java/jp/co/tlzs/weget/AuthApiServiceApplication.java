package jp.co.tlzs.weget;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.data.domain.AuditorAware;
import org.springframework.security.core.context.SecurityContextHolder;

import java.security.Principal;
import java.util.Optional;

@SpringBootApplication
public class AuthApiServiceApplication {
    public static void main(String[] args){
        SpringApplication.run(AuthApiServiceApplication.class, args);
    }

    @Bean
    AuditorAware<String> auditorAwareBean() {
        return () -> Optional.ofNullable(SecurityContextHolder.getContext().getAuthentication())
                .map(Principal::getName).or(() -> Optional.of("AuthApiService"));
    }

}
