package jp.co.tlzs.weget.authorization.service;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
public class AuthUserAuthenticationProvider extends DaoAuthenticationProvider {

    private final AuthenticationService authenticationService;

    public AuthUserAuthenticationProvider(AuthenticationService authenticationService,
                                          PasswordEncoder passwordEncoder) {
        this.authenticationService = authenticationService;
        setUserDetailsService(authenticationService);
        setPasswordEncoder(passwordEncoder);
    }

    @Override
    @Transactional(noRollbackFor = AuthenticationException.class)
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        return super.authenticate(authentication);
    }

    @Override
    protected void additionalAuthenticationChecks(UserDetails userDetails,
                                                  UsernamePasswordAuthenticationToken authentication) throws AuthenticationException {
        try {
            super.additionalAuthenticationChecks(userDetails, authentication);
        } catch (AuthenticationException exception) {
            // TODO do something for failure
            throw exception;
        }
        // TODO do something for successful
    }

}
