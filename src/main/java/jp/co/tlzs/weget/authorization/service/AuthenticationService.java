package jp.co.tlzs.weget.authorization.service;


import jp.co.tlzs.weget.authorization.model.LoginResponse;
import jp.co.tlzs.weget.authorization.web.form.UserPassForm;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.OAuth2Authentication;

/**
 * ログイン認証機能を実行します
 */
public interface AuthenticationService extends UserDetailsService {

    /**
     * ユーザ情報を受取り、validateチェックを行います。
     *
     * @param userPassForm ユーザ情報
     * @return ユーザのstatus情報
     */
    LoginResponse loginValidate(UserPassForm userPassForm);

    /**
     * 認証情報を受取り、アクセストークン（JWT）を生成します。
     *
     * @param oAuth2Authentication 認証情報
     * @return アクセストークン（JWT）
     */
    OAuth2AccessToken createAccessToken(OAuth2Authentication oAuth2Authentication);

}
