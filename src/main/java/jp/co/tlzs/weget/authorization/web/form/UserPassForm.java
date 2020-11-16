package jp.co.tlzs.weget.authorization.web.form;

/**
 * ユーザ情報のクラス
 * @author tlzs
 *
 */
public class UserPassForm {

    /**
     * Eメール.
     */
    private String email;
    /**
     * パスワード
     */
    private String password;


    /**
     * @return emailを取得します.
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param  email をセットします.
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * @return passwordを取得します.
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password をセットします.
     */
    public void setPassword(String password) {
        this.password = password;
    }

}
