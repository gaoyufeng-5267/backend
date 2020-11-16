package jp.co.tlzs.weget.authorization.model;

import org.springframework.stereotype.Component;

/**
 * レスポンス.
 * @author tlzs
 *
 */
@Component
public class LoginResponse {

    /**
     * authStatus.
     */
    private String authStatus;

    /**
     * secretKeyExist.
     */
    private boolean secretKeyExist;

    /**
     * @return secretKeyExist を取得します.
     */
    public boolean isSecretKeyExist() {
        return secretKeyExist;
    }

    /**
     * @param  secretKeyExist をセットします.
     */
    public void setSecretKeyExist(boolean secretKeyExist) {
        this.secretKeyExist = secretKeyExist;
    }

    /**
     * @return authStatus を取得します.
     */
    public String getAuthStatus() {
        return authStatus;
    }

    /**
     * @param  authStatus をセットします.
     */
    public void setAuthStatus(String authStatus) {
        this.authStatus = authStatus;
    }
}
