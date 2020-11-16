package jp.co.tlzs.weget.authorization.service;


import jp.co.tlzs.weget.authorization.error.ServiceIllegalArgumentException;
import jp.co.tlzs.weget.authorization.model.LoginResponse;
import jp.co.tlzs.weget.authorization.web.form.UserPassForm;
import jp.co.tlzs.weget.entity.Member;
import jp.co.tlzs.weget.redis.model.Auth;
import jp.co.tlzs.weget.redis.repository.AuthRepository;
import jp.co.tlzs.weget.repository.MembersRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.security.oauth2.provider.token.AccessTokenConverter;
import org.springframework.security.oauth2.provider.token.DefaultTokenServices;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.io.Serializable;
import java.time.Duration;
import java.util.Map;

import static org.springframework.http.HttpStatus.BAD_REQUEST;

@Service
public class AuthenticationServiceImpl implements AuthenticationService {

    private static final String USER_NOT_FOUND_PASSWORD = "userNotFoundPassword";
    private final Logger log = LoggerFactory.getLogger(getClass());

    private final DefaultTokenServices tokenServices;
    private final PasswordEncoder passwordEncoder;
    private final MembersRepository membersRepository;
    private final AuthRepository authRepository;
    private final Duration loginTimeout;

    public AuthenticationServiceImpl(
            @Value("${login.timeout}") String timeout,
            DefaultTokenServices tokenServices,
            PasswordEncoder passwordEncoder,
            MembersRepository membersRepository,
            AuthRepository authRepository
           ) {
        this.loginTimeout = Duration.parse(timeout);
        this.tokenServices = tokenServices;
        this.passwordEncoder = passwordEncoder;
        this.membersRepository = membersRepository;
        this.authRepository = authRepository;
    }




    public void loginFailed(Member authUser) {

        // TODO do something

    }

    @Override
    public LoginResponse loginValidate(UserPassForm userPassForm) {

        // emailの未入力チェック
        if (StringUtils.isEmpty(userPassForm.getEmail())) {
            throw new ServiceIllegalArgumentException(BAD_REQUEST, "0110");
        }

        // ユーザ情報取得
        Member authUser = getActivateUserByEmailNoError(userPassForm.getEmail());

        // ユーザ情報取得出来ない場合、
        if (authUser == null) {
            throw new ServiceIllegalArgumentException(BAD_REQUEST, "0111");
        }

        // ユーザがサインアップのままの場合
//        ユーザがサインアップのままの場合if (authUser.getStatus() == AuthStatus.SIGN_UP) {
//            throw new ServiceIllegalArgumentException(BAD_REQUEST, "0112");
//        }

        // 退会チェック
//        Account account = getAccountInfo(authUser.getAccountId());
//        if (account.getLeave()) {
//            // 該当ユーザが退会済の場合
//            throw new ServiceIllegalArgumentException(BAD_REQUEST, "0200");
//        }


        // パスワードの未入力チェック
        if (StringUtils.isEmpty(userPassForm.getPassword())) {
            throw new ServiceIllegalArgumentException(BAD_REQUEST, "0130");
        }

        // パスワードが異なる場合
        if (!passwordEncoder.matches(userPassForm.getPassword(), authUser.getPassword())) {
            this.loginFailed(authUser);
            throw new ServiceIllegalArgumentException(BAD_REQUEST, "0140");
        }

        LoginResponse loginResponse = new LoginResponse();
        // TODO

        return loginResponse;
    }

    @Override
    public OAuth2AccessToken createAccessToken(OAuth2Authentication oAuth2Authentication) {

        OAuth2AccessToken accessToken = tokenServices.createAccessToken(oAuth2Authentication);
        String jti = accessToken.getAdditionalInformation().get(AccessTokenConverter.JTI).toString();

        String accountId = oAuth2Authentication.getUserAuthentication().getName();
        Map<String, Serializable> extensions = oAuth2Authentication.getOAuth2Request().getExtensions();
        String ua = (String) extensions.get("ua");

        // ユーザ情報取得
        Member authUser = getActivateUserByAccountId(accountId);
        String email = authUser.getEmail();

        // redisへの認証情報の登録
        registRedisAuth(jti, accountId, ua, false, loginTimeout);

        return accessToken;
    }


//    private void kafkaSendTopic(String email, NoticeTemplateType noticeTemplateType, String sub, String language) {
//
//        Message<NoticeTemplatePrivate> message = MessageBuilder
//                .withPayload(new NoticeTemplatePrivate(email, noticeTemplateType.name(), sub,
//                        language))
//                .setHeader(KafkaHeaders.TOPIC, NoticeTopicType.NOTICE_TEMPLATE_PRIVATE.getCode())
//                .build();
//        kafkaTemplate.send(message);
//    }




    /**
     * emailからユーザを取得する.
     *
     * @param email email
     * @return 取得したtbl_auth_user情報
     */
    private Member getActivateUserByEmailNoError(String email) {
        return membersRepository.findByEmail(email).stream()
                .findAny().orElseGet(() -> null);
    }

    private Member getActivateUserByAccountId(String accountId) {
        return membersRepository.findById(accountId).stream()
                .findAny().orElseGet(() -> {
                    log.error("ActivateUser does not exist.(accountId={})", accountId);
                    throw new ServiceIllegalArgumentException(BAD_REQUEST, "0013");
                });
    }

    /**
     * 認証情報をredisに登録する.
     *
     * @param redisKey    redisのキー
     * @param accountId   アカウントID
     * @param userAgent   userAgent
     * @param status      ステータス
     * @param authTimeout redis登録時の有効期限
     */
    private void registRedisAuth(String redisKey, String accountId, String userAgent, boolean status,
                                 Duration authTimeout) {
        // redisに登録
        authRepository.save(new Auth(redisKey, accountId, userAgent, status), authTimeout);
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return null;
    }
}
