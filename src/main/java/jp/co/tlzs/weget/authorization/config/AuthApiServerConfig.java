package jp.co.tlzs.weget.authorization.config;

import javax.servlet.http.HttpServletRequest;
import jp.co.tlzs.weget.authorization.service.AuthUserAuthenticationProvider;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configurers.ResourceServerSecurityConfigurer;
import org.springframework.security.oauth2.provider.authentication.BearerTokenExtractor;
import org.springframework.security.oauth2.provider.token.DefaultTokenServices;
import org.springframework.security.oauth2.provider.token.store.JwtAccessTokenConverter;
import org.springframework.security.oauth2.provider.token.store.JwtTokenStore;
import org.springframework.security.oauth2.provider.token.store.KeyStoreKeyFactory;
import org.springframework.security.web.authentication.preauth.PreAuthenticatedAuthenticationToken;

import java.security.KeyPair;
import java.util.Enumeration;

@Configuration
public class AuthApiServerConfig {

    /**
     * アクセストークンの有効期限(秒)
     */
    private final int accessTokenValiditySeconds;
    /**
     * keystore.jks作成時のpassword
     */
    private final String keyStorePassword;
    /**
     * keystore.jks作成時のalias
     */
    private final String keyStoreAlias;

    public AuthApiServerConfig(@Value("${client.accessTokenValiditySeconds}") int accessTokenValiditySeconds,
                               @Value("${keyStore.password}") String keyStorePassword,
                               @Value("${keyStore.alias}") String keyStoreAlias) {
        this.accessTokenValiditySeconds = accessTokenValiditySeconds;
        this.keyStorePassword = keyStorePassword;
        this.keyStoreAlias = keyStoreAlias;
    }

    @Bean
    public DefaultTokenServices tokenServices(JwtAccessTokenConverter jwtAccessTokenConverter) {
        DefaultTokenServices tokenServices = new DefaultTokenServices();
        tokenServices.setTokenStore(new JwtTokenStore(jwtAccessTokenConverter));
        tokenServices.setTokenEnhancer(jwtAccessTokenConverter);
        tokenServices.setAccessTokenValiditySeconds(accessTokenValiditySeconds);
        return tokenServices;
    }

    @Bean
    public JwtAccessTokenConverter jwtAccessTokenConverter() {
        KeyPair keyPair = new KeyStoreKeyFactory(
                new ClassPathResource("keystore.jks"), keyStorePassword.toCharArray())
                .getKeyPair(keyStoreAlias);

        JwtAccessTokenConverter jwtAccessTokenConverter = new JwtAccessTokenConverter();
        jwtAccessTokenConverter.setKeyPair(keyPair);
        return jwtAccessTokenConverter;
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Configuration
    static class AuthServerConfigure extends WebSecurityConfigurerAdapter {

        private final AuthUserAuthenticationProvider authUserAuthenticationProvider;

        AuthServerConfigure(AuthUserAuthenticationProvider authUserAuthenticationProvider) {
            this.authUserAuthenticationProvider = authUserAuthenticationProvider;
        }

        @Override
        protected void configure(AuthenticationManagerBuilder auth) {
            auth.authenticationProvider(authUserAuthenticationProvider);
        }

        @Override
        protected void configure(HttpSecurity http) {
        }

        @Bean(name = "authenticationManager")
        @Override
        public AuthenticationManager authenticationManagerBean() throws Exception {
            return super.authenticationManagerBean();
        }
    }

    @Configuration
    static class ResourceServerConfigurer extends ResourceServerConfigurerAdapter {

        private final AuthenticationManager tokenAuthenticationManager;

        ResourceServerConfigurer(AuthenticationManager tokenAuthenticationManager) {
            this.tokenAuthenticationManager = tokenAuthenticationManager;
        }

        @Override
        public void configure(ResourceServerSecurityConfigurer resources) {
            resources.authenticationManager(tokenAuthenticationManager);
            resources.tokenExtractor(new BearerTokenExtractor() {

                @Override
                public Authentication extract(HttpServletRequest request) {
                    String tokenValue = extractToken(request);
                    if (tokenValue == null) {
                        // webSocket対応
                        Enumeration<String> headers = request.getHeaders("Sec-WebSocket-Protocol");
                        while (headers.hasMoreElements()) {
                            String s = headers.nextElement();
                            if ("JWT".equals(s)) {
                                continue;
                            }
                            tokenValue = s;
                            break;
                        }
                        if (tokenValue == null) {
                            tokenValue = request.getParameter("auth");
                        }
                    }

                    if (tokenValue != null) {
                        String userAgent = request.getHeader(HttpHeaders.USER_AGENT);
                        return new PreAuthenticatedAuthenticationToken(tokenValue, userAgent);
                    }
                    return null;
                }
            });
        }

        @Override
        public void configure(HttpSecurity http) {
            // 設定なしでのOverrideが必要。
        }
    }

}
