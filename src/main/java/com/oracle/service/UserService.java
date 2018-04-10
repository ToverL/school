package com.oracle.service;

import com.oracle.dao.MyfileDao;
import com.oracle.dao.UserDao;
import com.oracle.utils.ReadExcel;
import com.oracle.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.util.List;

@Service
public class UserService {
    @Autowired
    UserDao userDao;
    @Autowired
    MyfileDao myfileDao;

    @Transactional
    public User checkLogin(User user){
        User u=userDao.findOne(user);
        return u;
    }
    @Transactional
    public Boolean checkUserHave(String userid){
        if(userDao.findOneById(userid)==null)
            return false;
        else{
            return true;
        }
    }

    @Transactional
    public Boolean checkUserMemory(User user,double memory){
        if(user.getShenfen().equals("管理员"))
            return true;
        if(user.getMemory()+memory>user.getMemoryflag())
            return false;
        return true;
    }

    @Transactional
    public void saveUserFileDisk(String userid,String[]filedisk){
        myfileDao.deleteOldFile(userid);
        for(int i=0;i<filedisk.length;i++){
            myfileDao.saveUserHaveFile(userid,Integer.parseInt(filedisk[i]));
        }
        System.out.println("修改成功");
    }


    @Transactional
    public void upUserformExcel(String path){
        ReadExcel obj = new ReadExcel();
        File file = new File(path);
        List <User>userList = obj.readExcel(file);
        System.out.println("Excel中的新增User打印出来");
        for (User u:userList) {
           User user=userDao.findOneById(u.getUserid());
             if (user==null){
                 System.out.println(u);
                 userDao.save(u);
             }
        }
    }

}
