package com.oracle.handler;

import com.oracle.dao.DiskDao;
import com.oracle.dao.UserDao;
import com.oracle.service.MyfileService;
import com.oracle.service.UserService;
import com.oracle.vo.Disk;
import com.oracle.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import javax.sound.midi.Soundbank;
import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class UserHandler {
    @Autowired
    UserService userService;
    @Autowired
    DiskDao diskDao;
    @Autowired
    UserDao userDao;
    @Autowired
    MyfileService myfileService;

    @RequestMapping(value = "login.do",method = RequestMethod.GET)
    @ResponseBody
    public Map<String,Object> login(Model model, User user, HttpSession session){
        System.out.println(user);
        Map<String,Object> map=new HashMap<>();
        User user1 = userService.checkLogin(user);

        if(user1!=null){
            if((diskDao.findOneByid(user1.getLaterdisk())==null)){
                user1.setLaterdisk(-2);
            }
            map.put("success","success");
            session.setAttribute("user",user1);
            //防止最近访问目录被删除
            if((user1.getLaterdisk()!=-2)){
                Disk laterdisk=diskDao.findOneByid((int) user1.getLaterdisk());
                System.out.println("找到的最近访问：");
                System.out.println(laterdisk);
                session.setAttribute("laterdisk",laterdisk);
                User u=userDao.findOneById(laterdisk.getDiskuserid());
                session.setAttribute("laterdiskuser",u);
            }
        }else{
            map.put("success","error");
        }
        return map;

    }


    @RequestMapping(value = "selectuser.do")
    public String selectUserAll(Model model,HttpSession session){
        List<User> list = userDao.selectAll();
        model.addAttribute("user",list);
        return "userList.jsp";
    }

    /**
     * 用户详情
     * @param model
     * @param userid
     * @param session
     * @return
     */
    @RequestMapping(value = "findoneuser.do")
    public String FindOne(Model model,String userid,HttpSession session){
        System.out.println("来自详情");
        User user1=userDao.findOneById(userid);
        System.out.println(user1);
        Disk disk = new Disk();
        disk.setDiskid(-1);
        String checked=myfileService.findUserFileDisk(userid);
        List<Disk> list = diskDao.findChild(disk);
        model.addAttribute("checkbox",list);
        model.addAttribute("checked",checked);
        model.addAttribute("user",user1);
        return "userform.jsp";
    }

    @RequestMapping(value = "userself.do")
    public String UserSelf(Model model,HttpSession session){
        System.out.println("来自个人设置");
        User user1=(User) session.getAttribute("user");
        System.out.println(user1);
        Disk disk = new Disk();
        disk.setDiskid(-1);
        String checked=myfileService.findUserFileDisk(user1.getUserid());
        System.out.println(checked);
        List<Disk> list = diskDao.findChild(disk);
        model.addAttribute("checkbox",list);
        model.addAttribute("checked",checked);
        model.addAttribute("user",user1);
        return "selfform.jsp";
    }

    /**
     * 创建新用户
     * @param model
     * @param userid
     * @param session
     * @return
     */
    @RequestMapping(value = "createuser.do")
    public String Createuser (Model model,String userid,HttpSession session){
        Disk disk = new Disk();
        disk.setDiskid(-1);
        List<Disk> list = diskDao.findChild(disk);
        model.addAttribute("checkbox",list);
        return "enroll.jsp";
    }




    @RequestMapping(value = "saveuser.do")
    public String SaveUser(Model model,User user,String[]filebox,HttpSession session){
        System.out.println("修改为：");
        System.out.println(Arrays.toString(filebox));
        System.out.println(user);
        User u=userDao.findOneById(user.getUserid());
        userService.saveUserFileDisk(user.getUserid(),filebox);
        if (u==null){
            userDao.replace(user);
        }else {
            userDao.replace(u);
        }
        return "selectuser.do";
    }


    @RequestMapping(value = "savemyself.do")
    public String SaveMyself(Model model,User user,String[]filebox,HttpSession session){
        System.out.println("修改为：");
        System.out.println(user);
        User u=userDao.findOneById(user.getUserid());
        user.setPassword(u.getPassword());
        System.out.println(user);
        userDao.replace(user);
        return "mine.do";
    }



    @RequestMapping(value = "findname.do")
    public String findName(Model model,User user){
        System.out.println("查询："+user.getName());
        List<User> list = userDao.findName(user);
        System.out.println("查询到：");
        System.out.println(list);
        model.addAttribute("user",list);
        return "userList.jsp";
    }


    @RequestMapping(value = "setpassword.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,String> setPassword(Model model,User user,HttpSession session){
        Map<String,String>map=new HashMap();
        System.out.println("重置密码："+user.getPassword());
        userDao.setPassword(user);
        map.put("success","success");
        return map;
    }

    @RequestMapping(value = "setmypassword.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,String> setMyPassword(Model model,String newpassword,String oldpassword,HttpSession session){
        Map<String,String>map=new HashMap();
        System.out.println("访问到修改密码");
        System.out.println(newpassword+oldpassword);

            User u=(User) session.getAttribute("user");
            if(u.getPassword().equals(oldpassword)){
                System.out.println("重置密码："+newpassword);
                u.setPassword(newpassword);
                userDao.replace(u);
                map.put("success","success");
            }else{
                map.put("success","error");
            }
        return map;
    }



}
