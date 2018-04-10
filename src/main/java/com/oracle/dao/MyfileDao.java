package com.oracle.dao;

import com.oracle.vo.Myfile;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface MyfileDao {
    public void saveUserHaveFile(@Param("userid") String userid, @Param("filediskid") int filediskid);
    public void deleteOldFile(@Param("userid") String userid);
    public List<Myfile> findUserFileDisk(@Param("userid") String userid);
}
