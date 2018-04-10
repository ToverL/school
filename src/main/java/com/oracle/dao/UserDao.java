package com.oracle.dao;

import com.oracle.vo.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserDao {
    public void save(User user);
    public User findOne(User user);//登录验证
    public User findOneById(@Param("userid") String  userid);
    public void setHaveList(@Param("userid") String userid);
    public void setHaveList_0(@Param("userid") String userid);
    public List<User> findNotHaveDir();
    public void updateMemory(User user);
    public void saveReplace(User user);
    public List<User> selectAll();
    public void replace(User user);
    public void setPassword(User user);
    public List<User>findName(User user);
}
