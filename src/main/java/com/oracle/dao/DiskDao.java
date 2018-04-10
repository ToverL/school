package com.oracle.dao;

import com.oracle.vo.Disk;
import com.oracle.vo.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DiskDao {
    public List<Disk> findChild(Disk disk);
    public void savedisk(Disk disk);
    public Disk findOneByid(@Param("diskid") int diskid);
    public void delete_self(Disk disk);
    public void delete_child(Disk disk);
    public void setdisk(Disk disk);
    public void setHaveChild_1(@Param("diskid") int diskid);
    public void setHaveChild_0(@Param("diskid") int diskid);
    public void updateReplaceAll(Disk disk);
    public List<Disk> findDiskByUserId(@Param("diskuserid") String diskuserid);
    public void memorySizeLenUp(Disk disk);
    public Disk findOneByUser(User user);
    public Disk chackListIsHave(Disk disk);
}
