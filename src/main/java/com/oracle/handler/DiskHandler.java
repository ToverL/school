package com.oracle.handler;

import com.oracle.dao.DiskDao;
import com.oracle.dao.MyfileDao;
import com.oracle.dao.UserDao;
import com.oracle.service.DiskService;
import com.oracle.service.UserService;
import com.oracle.vo.Disk;
import com.oracle.vo.Myfile;
import com.oracle.vo.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.jms.Session;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sound.midi.Soundbank;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class DiskHandler {
    @Autowired
    UserService userService;
    @Autowired
    DiskService diskService;
    @Autowired
    DiskDao diskDao;
    @Autowired
    UserDao userDao;
    @Autowired
    MyfileDao myfileDao;


    @RequestMapping(value = "ship.do")
    public String Ship(Model model,HttpSession session){
        System.out.println("我是教案中转站");
        session.setAttribute("root",0);
        return "computer.do?diskid=0";
    }


    @RequestMapping(value = "ship2.do")
    public String Ship2(Model model,HttpSession session){
        System.out.println("我是档案中转站");
        session.setAttribute("root",-1);
        return "computer.do?diskid=-1&path=computer2.jsp";
    }

    @RequestMapping(value = "computer.do")
    public String Disklist(Model model,HttpSession session,Disk disk,String path){

        //上传操作
        String path1=diskService.findPath((int)disk.getDiskid());
        session.setAttribute("diskfather",path1);
        System.out.println("session里边的path"+session.getAttribute("diskfather"));
        //当前位置显示位置
        model.addAttribute("diskfather",disk.getDiskid());
        model.addAttribute("diskname",disk.getDiskname());
      //找儿子
       List<Disk>list = diskService.findDao(disk);
       int disknum=list.size();
       model.addAttribute("disk", list);
       model.addAttribute("disknum",disknum);
       model.addAttribute("disktype",disk.getDisktype());
       if(path!=null){
           //进行记录最近访问
           if (path.equals("filelist.jsp")){
               session.setAttribute("diskuserid",diskDao.findOneByid((int)disk.getDiskid()).getDiskuserid());
               System.out.println("父亲"+diskDao.findOneByid((int)disk.getDiskid()).getDiskuserid());
               User user=(User) session.getAttribute("user");
               System.out.println("session里的user");
               System.out.println(user);
               System.out.println("当前的diskID");
               System.out.println(disk.getDiskid());
               user.setLaterdisk((int) disk.getDiskid());
               userDao.saveReplace(user);
               session.setAttribute("user",user);
               Disk laterdisk=diskDao.findOneByid((int) disk.getDiskid());
               System.out.println("找到的最近访问：");
               System.out.println(laterdisk);
               session.setAttribute("laterdisk",laterdisk);
               User u=userDao.findOneById(laterdisk.getDiskuserid());
               session.setAttribute("laterdiskuser",u);
               System.out.println("最近访问");
               System.out.println(u);
           }

           return path;
       }else {
           return "computer.jsp";
       }
    }

    @RequestMapping(value = "save.do")
    public String saveJiaoAn(Disk disk,HttpSession session){
        Disk disk1 = diskDao.findOneByid((int)disk.getDiskfather());
        if(disk1!=null){
            disk.setDiskuserid(disk1.getDiskuserid());
        }
        diskService.saveJiaoAn(disk);
        int root=(int)session.getAttribute("root");
        if(root==-1){
            return "ship2.do";
        }
        return "ship.do";
    }

    @RequestMapping(value = "delete.do")
    public String delete(Disk disk,HttpSession session){
        String diskuserid =disk.getDiskuserid();
        System.out.println("id:"+diskuserid);
        System.out.println("用户访问");
        diskService.delete(disk);
        if(diskDao.findDiskByUserId(diskuserid).isEmpty()){
            System.out.println("删除完教案了");
            userDao.setHaveList_0(diskuserid);
        }
        //重新设置最近访问
        User user1=(User) session.getAttribute("user");
        if((diskDao.findOneByid(user1.getLaterdisk())==null)){
            user1.setLaterdisk(-2);
            Disk dd=(Disk) session.getAttribute("laterdisk");
            dd.setDisklen(dd.getDisklen()-1);
            session.setAttribute("laterdisk",dd);
            session.setAttribute("user",user1);
        }
        int root=(int)session.getAttribute("root");
        if (root==-5){
            return "mine.do";
        }
        if(root==-1){
            return "ship2.do";
        }
        return "ship.do";
    }

    @RequestMapping(value = "setbase.do")
    public String setdisk(Disk disk,HttpSession session){
        diskService.setDisk(disk);
        int root=(int)session.getAttribute("root");
        if(root==-1){
            return "ship2.do";
        }
        return "ship.do";
    }

    @RequestMapping(value = "createoneuserdisk.do")
    public String createOneUserdisk(Disk disk,HttpSession session){

        if(userService.checkUserHave(disk.getDiskuserid())&&diskDao.chackListIsHave(disk)==null)
        {

            System.out.println("用户存在，开始创建文件夹");
            diskService.createOneUserDir(disk);

            return "ship.do";
        }
        else {
            System.out.println("不存在此用户");
            int root=(int)session.getAttribute("root");
            return "ship.do";
        }
    }


    @RequestMapping(value = "createnewyear.do")
    public String createNewYear(Disk disk){
        if(diskDao.chackListIsHave(disk)==null){
            diskService.createNewYear((int)disk.getDiskfather(),disk.getDiskname());
            System.out.println("可以创建");
        }else{
            System.out.println("已经存在！");
        }
        return "ship.do";
    }


    @RequestMapping(value = "createalldir.do")
    public String createAllUserdisk(Disk disk){
        System.out.println("被访问");
        System.out.println(disk.getDiskfather());
            diskService.createAllUserDir((int)disk.getDiskfather());
            return "ship.do";
    }


    @RequestMapping(value = "changedata.do",method = RequestMethod.GET)
    @ResponseBody
    public Map<String,Object> changeData(String path,HttpSession session){
        Map<String,Object> map=new HashMap<>();
        System.out.println(path);
        if (path==null){
            map.put("success","error");
        }else{
            session.setAttribute("path",path);
            map.put("success","success");
        }
        return map;
    }


    @RequestMapping(value = "mine.do")
    public String myDisklist(Model model,HttpSession session,Disk disk,String path){
        System.out.println("访问到了");
        User user = (User)session.getAttribute("user");
        Disk JiaoAn = diskService.findMyJiaoAndisk(user);
        Disk DangAn=diskService.createMyFileDisk(user.getUserid());
        System.out.println(DangAn);
        model.addAttribute("jiaoan",JiaoAn);
        model.addAttribute("dangan",DangAn);
        return "computer3.jsp";
    }


    @RequestMapping(value = "UpUserExcel.do")
    public String Upuserexceldo(Model model,Disk disk){
        System.out.println("正在上传");
        Disk disk1=diskDao.findOneByid((int) disk.getDiskid());
        userService.upUserformExcel(disk1.getPath());
        return "mine.do";
    }

    @RequestMapping(value = "upuser.do")
    public String UpUserInfo(Model model,HttpSession session){
        //管理员私人根目录默认为-5
        Disk disk = diskDao.findOneByid(-5);
        String path="upuser.jsp";
        return "computer.do?diskid="+disk.getDiskid()+"&diskname="+disk.getDiskname()+"&diskfather="+disk.getDiskfather()
                +"&path=upuser.jsp";
    }

    /**
     * 个人档案
     * @param model
     * @param session
     * @param disk
     * @param path
     * @return
     */
    @RequestMapping(value = "myfilelist.do")
    public String myFilelist(Model model,HttpSession session,Disk disk,String path){

        session.setAttribute("root",-1);
        model.addAttribute("diskfather",disk.getDiskid());
        model.addAttribute("diskname",disk.getDiskname());
        //找儿子
        User user = (User)session.getAttribute("user");
        List<Myfile>list = myfileDao.findUserFileDisk(user.getUserid());
        List<Disk>list1 = new ArrayList<>();
        for (Myfile l:list) {
            list1.add(diskDao.findOneByid((int)l.getFilediskid()));
        }
        int disknum=list1.size();
        model.addAttribute("disk", list1);
        model.addAttribute("disknum",disknum);
        model.addAttribute("disktype",disk.getDisktype());
        return path;
    }
}