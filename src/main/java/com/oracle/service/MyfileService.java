package com.oracle.service;

import com.oracle.dao.MyfileDao;
import com.oracle.vo.Myfile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MyfileService {
@Autowired
    MyfileDao myfileDao;


public String findUserFileDisk(String userid){
    List<Myfile> list = myfileDao.findUserFileDisk(userid);
    System.out.println(list);
    StringBuilder sb=new StringBuilder("");
    int i=0;
    for (Myfile l:list) {
        i++;
        if(list.size()==i){
            sb.append(l.getFilediskid());
        }else {
            sb.append(l.getFilediskid());
            sb.append(",");
        }
    }
    return sb.toString();
}


}
