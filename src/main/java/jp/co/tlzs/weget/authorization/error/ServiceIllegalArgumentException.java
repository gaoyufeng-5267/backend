package jp.co.tlzs.weget.authorization.error;

import org.springframework.http.HttpStatus;

/**
 * service側でエラーとなった場合に利用する共通Exceptionクラスです.
 * @author tlzs
 *
 */
public class ServiceIllegalArgumentException extends RuntimeException {

    private final HttpStatus status;

    private final String code;

    private final String[] msgArgs;

    public ServiceIllegalArgumentException(HttpStatus status, String code, String... msgArgs) {
        this.status = status;
        this.code = code;
        this.msgArgs = msgArgs;
    }

    /**
     * @return status
     */
    public HttpStatus getStatus() {
        return status;
    }

    /**
     * @return code
     */
    public String getCode() {
        return code;
    }

    /**
     * @return message
     */
    public String[] getMsgArgs() {
        return msgArgs;
    }
}
