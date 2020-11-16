package jp.co.tlzs.weget.authorization.service;

import jp.co.tlzs.weget.entity.Members;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

public class AuthUserDetails extends User {

    private static final long serialVersionUID = 1L;

    private final Members authUser;

    public AuthUserDetails(Members authUser) {
        super(authUser.getMemberId(), authUser.getPassword(), AuthorityUtils.createAuthorityList("USER"));
        this.authUser = authUser;
    }

    public Members getAuthUser() {
        return authUser;
    }

    @Override
    public boolean isAccountNonLocked() {
//        boolean locked = authUser.getLocked();
//        if (locked) {
//            LocalDateTime unlockedDate = authUser.getUnlockedDate();
//            return unlockedDate != null && unlockedDate.isBefore(LocalDateTime.now());
//        }
        return true;
    }
}
