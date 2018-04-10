package com.oracle.service;

import com.mchange.v1.db.sql.schemarep.ForeignKeyRep;
import com.oracle.dao.DiskDao;
import com.oracle.dao.MyfileDao;
import com.oracle.dao.UserDao;
import com.oracle.utils.DelNullDir;
import com.oracle.vo.Disk;
import com.oracle.vo.Myfile;
import com.oracle.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sun.rmi.log.LogInputStream;

import java.io.File;
import java.sql.Timestamp;
import java.util.*;

@Service
public class DiskService {
    @Autowired
    DiskDao diskDao;
    @Autowired
    UserDao userDao;
    @Autowired
    MyfileDao myfileDao;
    @Transactional
    public List<Disk> findDao(Disk disk){

        List<Disk>list=diskDao.findChild(disk);
        return list;
    }
    @Transactional
    public void saveJiaoAn(Disk disk){
        disk.setCreatetime(new java.sql.Timestamp(System.currentTimeMillis()));
        disk.setPermission("public");
        if(disk.getDiskfather()!=0&&disk.getDiskfather()!=-1){
            disk.setHavefather(1);
            diskDao.setHaveChild_1((int)disk.getDiskfather());
        }
        diskDao.savedisk(disk);
    }
    @Transactional
    public void saveFile(Disk disk){
        disk.setCreatetime(new java.sql.Timestamp(System.currentTimeMillis()));
        disk.setPermission("public");
        if(disk.getDiskfather()!=0&&disk.getDiskfather()!=-1){
            disk.setHavefather(1);
            diskDao.setHaveChild_1((int)disk.getDiskfather());
        }
        diskDao.savedisk(disk);

        System.out.println("这里没问题3");
        //递归增长内存
        dfs2(disk,disk.getDisksize());
        System.out.println("这里没问题4");
    }

    @Transactional

    public String findPath(int diskfather){
        Stack<Integer>stack=new Stack<>();
        stack.push(diskfather);
        dfs1(stack,diskfather);
        System.out.println("**************");
        System.out.println(stack);
        StringBuilder sb=new StringBuilder("");
        sb.append(stack.pop());
        int flag=-888888;
        while(!stack.empty()){
            if (stack.peek()!=flag){
                flag=stack.peek();
                sb.append(File.separator);
                sb.append(stack.pop());
            }else {
                break;
            }
            System.out.println(sb);
        }
        return sb.toString();
    }

    //深搜找父亲---还原路径
    public int dfs1(Stack<Integer>stack, int diskfather){
        Disk d=diskDao.findOneByid(diskfather);
        if(d!=null){
            if(d.getHavefather()!=0){
                stack.push((int)d.getDiskid());
                dfs1(stack,(int) d.getDiskfather());
            }else{
                stack.push((int)d.getDiskid());
                stack.push(0);
            }
        }
        return 0;
    }


    public Disk findMyJiaoAndisk(User user){
        Disk d1=diskDao.findOneByUser(user);
        return d1;
    }

    /**
     * 递归删除内存
     * @param disk
     * @param memory
     * @return
     */
    public int dfs3(Disk disk,double memory){
        Disk d=diskDao.findOneByid((int) disk.getDiskfather());
        if(d!=null){

            d.setDisksize((double)( d.getDisksize()-memory));
            d.setDisklen(d.getDisklen()-1);
            diskDao.memorySizeLenUp(d);
            if(d.getHavefather()!=0){
                dfs3(d,memory);
            }
            return 0;
        }else{
            disk.setDisksize((double)( disk.getDisksize()-memory));
            disk.setDisklen(disk.getDisklen()-1);
            diskDao.memorySizeLenUp(disk);
            return 0;
        }

    }


    /**
     * 文件夹递归增长内存
     * @param disk
     * @param memory
     * @return
     */
    @Transactional
    public int dfs2(Disk disk,double memory){
        Disk d=diskDao.findOneByid((int) disk.getDiskfather());
        System.out.println(d);
        if(d!=null){
            d.setDisksize((double)( d.getDisksize()+memory));
            d.setDisklen(d.getDisklen()+1);
            diskDao.memorySizeLenUp(d);
            if(d.getHavefather()!=0){
                dfs2(d,memory);
            }
            return 0;
        }else{
            disk.setDisksize((double)( disk.getDisksize()+memory));
            disk.setDisklen(disk.getDisklen()+1);
            diskDao.memorySizeLenUp(disk);
            return 0;
        }

    }



    //深搜删儿子--删除所有子节点
    public void dfs(Disk disk){
        Disk d=diskDao.findOneByid((int)disk.getDiskid());
        if (d.getHavechild()==1){
            List<Disk> list=diskDao.findChild(d);
            for (Disk l:list) {
                dfs(l);
            }
            dfs(d);
        }else if(d.getHavechild()==0){
            System.out.println("当前磁盘类型"+d.getDisktype());
            if(d.getDisktype().equals("磁盘")||d.getDisktype().equals("文件夹")||d.getDisktype().equals("真实文件夹")){
                diskDao.delete_self(d);
                diskDao.setHaveChild_0((int)d.getDiskfather());
                System.out.println(d.getDiskname()+"已经删掉");
                return;
            }else{
                try {
                    File file = new File(d.getPath());
                    if (file.delete()) {
                        System.out.println(d.getDiskname()+"已经删掉");
                        //内存删除
                        dfs3(d,d.getDisksize());
                        diskDao.delete_self(d);
                        diskDao.setHaveChild_0((int)d.getDiskfather());
                    } else {
                        System.out.println("删除失败");
                    }
                } catch (Exception e) {
                    System.out.println("Exception occured");
                    e.printStackTrace();
                }
                return;
            }
        }
    }

    /**
     * 创建临时档案空间
     * @param userid
     * @return
     */
    @Transactional
    public Disk createMyFileDisk(String userid)
    {
        Disk disk = new Disk();
        List<Myfile>list =myfileDao.findUserFileDisk(userid);
        if (list.isEmpty()){
            return null;
        }
        disk.setDiskid(-1);
        disk.setDisktype("磁盘");
        disk.setDiskname("我的档案");
        disk.setDisksize(0);
        for (Myfile f:list) {
            Disk d=diskDao.findOneByid((int)f.getFilediskid());
            disk.setDisklen(disk.getDisklen()+d.getDisklen());
            disk.setDisksize(disk.getDisksize()+d.getDisksize());
        }
        System.out.println("包装好的disk:");
        System.out.println(disk);
        return disk;
    }



    //删除文件以及文件夹（包括真实文件和真实文件夹）
    @Transactional
    public void delete(Disk disk){
        //找到此文件的父亲目录的拥有者
        Disk disk1=diskDao.findOneByid((int)disk.getDiskid());
        Disk diskfather=diskDao.findOneByid((int)disk1.getDiskfather());
        //删除文件后还原内存
        User user=userDao.findOneById(diskfather.getDiskuserid());
        user.setMemory(user.getMemory()-disk1.getDisksize());
        System.out.println("修改为");
        System.out.println(user.getMemory());
        userDao.updateMemory(user);
        this.dfs(disk1);
        //删除真实路径下的空文件夹
        new DelNullDir().deleteNullDir();
    }
    @Transactional
    public void setDisk(Disk disk){
        diskDao.setdisk(disk);
    }


    /**
     * 动态创建子目录的年份下所有子目录
     * @param diskfather
     * @param diskname
     */
    @Transactional
public void createNewYear(int diskfather,String diskname){
        Disk dd= new Disk();
        dd.setDiskid(diskfather);
        List<Disk> list=diskDao.findChild(dd);
    for (Disk disk1:list) {
        System.out.println("找到子目录："+disk1.getDiskname());
        Disk disk = new Disk();
        disk.setDiskid(disk1.getDiskid());
        disk.setDiskname(disk1.getDiskname());
        disk.setDiskuserid(disk1.getDiskuserid());
        disk.setCreatetime(new Timestamp(System.currentTimeMillis()));
        disk.setPermission("public");
        disk.setDisktype("文件夹");
        if(disk.getDiskfather()!=0&&disk.getDiskfather()!=-1)
            disk.setHavefather(1);

        long flag_1=disk.getDiskid();
        String year=diskname;
        for(int j=1;j<=2;j++){
            disk.setDiskname(year+"("+j+")");
            disk.setDisktype("文件夹");
            disk.setDiskfather(flag_1);
            disk.setDiskid(0);
            if(disk.getDiskfather()!=0&&disk.getDiskfather()!=-1)
                disk.setHavefather(1);
            diskDao.savedisk(disk);
            diskDao.setHaveChild_1((int) flag_1);
            long flag=disk.getDiskid();
            for(int i=1;i<=6;i++){
                disk.setDiskname(i+"年级");
                disk.setDisktype("文件夹");
                disk.setDiskfather(flag);
                disk.setDiskid(0);
                if(disk.getDiskfather()!=0&&disk.getDiskfather()!=-1)
                    disk.setHavefather(1);
                diskDao.savedisk(disk);
                diskDao.setHaveChild_1((int) flag);
/////////////////////////////////////////////
                long flag2=disk.getDiskid();
                disk.setDiskname("教案");
                disk.setDisktype("真实文件夹");
                disk.setDiskfather(flag2);
                disk.setDiskid(0);
                if(disk.getDiskfather()!=0&&disk.getDiskfather()!=-1)
                    disk.setHavefather(1);
                diskDao.savedisk(disk);
                diskDao.setHaveChild_1((int)flag2);
                disk.setDiskname("课件");
                disk.setDisktype("真实文件夹");
                disk.setDiskfather(flag2);
                disk.setDiskid(0);
                if(disk.getDiskfather()!=0&&disk.getDiskfather()!=-1)
                    disk.setHavefather(1);
                diskDao.savedisk(disk);
                diskDao.setHaveChild_1((int)flag2);
                userDao.setHaveList(disk.getDiskuserid());
            }
        }

    }
}


    /**
     * 动态给所有无空间的用户创建目录
     * @param diskfather
     */
    @Transactional
    public void createAllUserDir(int diskfather){
        Disk disk_base=diskDao.findOneByid(diskfather);
        List<Disk> list = new ArrayList<>();
        List<User> users=userDao.findNotHaveDir();
        for (User u:users) {
            if(u.getFenzu().equals(disk_base.getDiskname())){
                System.out.println();
                Disk disk1 = new Disk();
                disk1.setDiskfather(diskfather);
                disk1.setDiskuserid(u.getUserid());
                disk1.setDiskname(u.getName());
                list.add(disk1);
            }
        }
        for (Disk disk:list) {
            disk.setCreatetime(new Timestamp(System.currentTimeMillis()));
            disk.setPermission("public");
            disk.setDisktype("文件夹");
            if(disk.getDiskfather()!=0&&disk.getDiskfather()!=-1)
                disk.setHavefather(1);
            diskDao.savedisk(disk);
            diskDao.setHaveChild_1((int)disk.getDiskfather());
            long flag_1=disk.getDiskid();
            Calendar date=Calendar.getInstance();
            String year=String.valueOf(date.get(Calendar.YEAR));
            for(int j=1;j<=2;j++){
                disk.setDiskname(year+"("+j+")");
                disk.setDisktype("文件夹");
                disk.setDiskfather(flag_1);
                disk.setDiskid(0);
                if(disk.getDiskfather()!=0&&disk.getDiskfather()!=-1)
                    disk.setHavefather(1);
                diskDao.savedisk(disk);
                diskDao.setHaveChild_1((int)flag_1);
                long flag=disk.getDiskid();
                for(int i=1;i<=6;i++){
                    disk.setDiskname(i+"年级");
                    disk.setDisktype("文件夹");
                    disk.setDiskfather(flag);
                    disk.setDiskid(0);
                    if(disk.getDiskfather()!=0&&disk.getDiskfather()!=-1)
                        disk.setHavefather(1);
                    diskDao.savedisk(disk);
                    diskDao.setHaveChild_1((int)flag);

                    long flag2=disk.getDiskid();
                    disk.setDiskname("教案");
                    disk.setDisktype("真实文件夹");
                    disk.setDiskfather(flag2);
                    disk.setDiskid(0);
                    if(disk.getDiskfather()!=0&&disk.getDiskfather()!=-1)
                        disk.setHavefather(1);
                    diskDao.savedisk(disk);
                    diskDao.setHaveChild_1((int)disk.getDiskfather());
                    disk.setDiskname("课件");
                    disk.setDisktype("真实文件夹");
                    disk.setDiskfather(flag2);
                    disk.setDiskid(0);
                    if(disk.getDiskfather()!=0&&disk.getDiskfather()!=-1)
                        disk.setHavefather(1);
                    diskDao.savedisk(disk);
                    diskDao.setHaveChild_1((int)flag2);
                    userDao.setHaveList(disk.getDiskuserid());
                }
            }
        }

    }





    /**
     * 为特定ID创建目录
     * @param disk
     */
    @Transactional
    public void createOneUserDir(Disk disk){
        User user=userDao.findOneById(disk.getDiskuserid());
        disk.setDiskname(user.getName());
        disk.setCreatetime(new Timestamp(System.currentTimeMillis()));
        disk.setPermission("public");
        disk.setDisktype("文件夹");
        if(disk.getDiskfather()!=0&&disk.getDiskfather()!=-1)
            disk.setHavefather(1);
        diskDao.savedisk(disk);
        diskDao.setHaveChild_1((int)disk.getDiskfather());
        long flag_1=disk.getDiskid();
        Calendar date=Calendar.getInstance();
        String year=String.valueOf(date.get(Calendar.YEAR));
        for(int j=1;j<=2;j++){
            disk.setDiskname(year+"("+j+")");
            disk.setDisktype("文件夹");
            disk.setDiskfather(flag_1);
            disk.setDiskid(0);
            if(disk.getDiskfather()!=0&&disk.getDiskfather()!=-1)
                disk.setHavefather(1);
            diskDao.savedisk(disk);
            diskDao.setHaveChild_1((int)disk.getDiskfather());
            long flag=disk.getDiskid();
            for(int i=1;i<=6;i++){
                disk.setDiskname(i+"年级");
                disk.setDisktype("文件夹");
                disk.setDiskfather(flag);
                disk.setDiskid(0);
                if(disk.getDiskfather()!=0&&disk.getDiskfather()!=-1)
                    disk.setHavefather(1);
                diskDao.savedisk(disk);
                diskDao.setHaveChild_1((int)disk.getDiskfather());
                userDao.setHaveList(user.getUserid());
///////////////////////////////////////////////////////////
                long flag2=disk.getDiskid();
                disk.setDiskname("教案");
                disk.setDisktype("真实文件夹");
                disk.setDiskfather(flag2);
                disk.setDiskid(0);
                if(disk.getDiskfather()!=0&&disk.getDiskfather()!=-1)
                    disk.setHavefather(1);
                diskDao.savedisk(disk);
                diskDao.setHaveChild_1((int)disk.getDiskfather());
                disk.setDiskname("课件");
                disk.setDisktype("真实文件夹");
                disk.setDiskfather(flag2);
                disk.setDiskid(0);
                if(disk.getDiskfather()!=0&&disk.getDiskfather()!=-1)
                    disk.setHavefather(1);
                diskDao.savedisk(disk);
                diskDao.setHaveChild_1((int)disk.getDiskfather());
                userDao.setHaveList(disk.getDiskuserid());
            }
        }

    }

}
