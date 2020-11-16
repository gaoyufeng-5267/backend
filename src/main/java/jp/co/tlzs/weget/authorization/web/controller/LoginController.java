package jp.co.tlzs.weget.authorization.web.controller;


import jp.co.tlzs.weget.authorization.constant.AuthConst;
import jp.co.tlzs.weget.authorization.model.LoginResponse;
import jp.co.tlzs.weget.authorization.service.AuthenticationService;
import jp.co.tlzs.weget.authorization.web.form.UserPassForm;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.AuthorizationRequest;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;


import java.util.Arrays;
import java.util.Map;

import static org.springframework.http.HttpHeaders.USER_AGENT;
import static org.springframework.http.HttpStatus.OK;

/**
 * ログイン用
 *
 * @author tlzs
 */
@RestController
@RequestMapping("/login")
public class LoginController {

    private final Logger log = LoggerFactory.getLogger(getClass());

    private final AuthenticationManager authenticationManager;
    private final AuthenticationService authenticationService;

    public LoginController(AuthenticationManager authenticationManager, AuthenticationService authenticationService) {
        this.authenticationManager = authenticationManager;
        this.authenticationService = authenticationService;
    }

    @PostMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<LoginResponse> postRequest(@RequestBody UserPassForm userPassForm,
                                                     @RequestHeader HttpHeaders headers) {

        // 入力チェック
        LoginResponse loginResponse = authenticationService.loginValidate(userPassForm);

        Authentication userAuth = new UsernamePasswordAuthenticationToken(userPassForm.getEmail(),
                userPassForm.getPassword());

        // email、passwordからauthDBを検証する認証処理
        log.info("Authenticate start. (email={})", userPassForm.getEmail());
        Authentication authenticate = authenticationManager.authenticate(userAuth);
        log.info("Authenticate end. (email={})", userPassForm.getEmail());

        OAuth2AccessToken oAuth2AccessToken = this.getOAuth2AccessToken(headers, authenticate);
        return new ResponseEntity<>(loginResponse, this.crateHeaders(oAuth2AccessToken), OK);
    }

    private HttpHeaders crateHeaders(OAuth2AccessToken oAuth2AccessToken) {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.add(HttpHeaders.ACCESS_CONTROL_EXPOSE_HEADERS, HttpHeaders.AUTHORIZATION);
        responseHeaders.add(HttpHeaders.AUTHORIZATION,
                OAuth2AccessToken.BEARER_TYPE + AuthConst.HALF_SIZE_SPACE + oAuth2AccessToken.getValue());
        responseHeaders.setContentType(MediaType.APPLICATION_JSON_UTF8);
        return responseHeaders;
    }

    private OAuth2AccessToken getOAuth2AccessToken(HttpHeaders headers, Authentication authenticate) {
        String ua = headers.getFirst(USER_AGENT);
        AuthorizationRequest authorizationRequest = new AuthorizationRequest("qirin", Arrays.asList("read", "write"));
        authorizationRequest.setExtensions(Map.of("ua", ua != null ? ua : "none"));
        OAuth2Authentication oAuth2Authentication = new OAuth2Authentication(authorizationRequest.createOAuth2Request(), authenticate);
        return authenticationService.createAccessToken(oAuth2Authentication);
    }
}
