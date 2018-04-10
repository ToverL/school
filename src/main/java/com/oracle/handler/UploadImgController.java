package com.oracle.handler;

import com.oracle.config.ConfigReader;
import com.oracle.config.UploadError;
import com.oracle.config.UploadException;
import com.oracle.dao.DiskDao;
import com.oracle.dao.UserDao;
import com.oracle.service.DiskService;
import com.oracle.service.UserService;
import com.oracle.utils.FileUtil;
import com.oracle.utils.Md5Util;
import com.oracle.vo.Disk;
import com.oracle.vo.UploadMsg;
import com.oracle.vo.User;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * 上传图片
 *
 * @author ChenGR
 */
@Controller
public class UploadImgController {

    @Autowired
    DiskService diskService;
    @Autowired
    UserService userService;
    @Autowired
    UserDao userDao;
    @Autowired
    DiskDao diskDao;

    /**
     * 日志实例
     */
    private static final Logger logger = Logger.getLogger(UploadImgController.class);

    @RequestMapping(value = "upload.do")
    @ResponseBody
    public UploadMsg upload(@RequestParam(value = "file", required = false) MultipartFile file,
                            HttpServletRequest request, ModelMap model, MultipartHttpServletRequest req1) {
        UploadMsg um = new UploadMsg();
        int Diskfather = Integer.parseInt(req1.getParameter("diskfather"));
        String diskfather = req1.getParameter("path");
        //当前用户
        User user = userDao.findOneById(req1.getParameter("userid"));
        System.out.println("上传测试接收diskfather:" + diskfather + user);
        try {
            logger.info("---------------- upload img begin ---------------------");
            // 文件是否为空
            if (file.getSize() == 0 || file.isEmpty()) {
                throw new UploadException(UploadError.FILE_EMPTY);
            }
            System.out.println("上传文件：" + (file.getSize() / 1024));
            System.out.println("上传限制：" + ConfigReader.getUpload_img_maxsize() / 1024);
            // 文件是否过大
            if (file.getSize() > ConfigReader.getUpload_img_maxsize()) {
                throw new UploadException(UploadError.FILE_TOBIG);
            }
            System.out.println("路径：" + ConfigReader.getUpload_img_path());
            String path = FileUtil.getSavePath1(ConfigReader.getUpload_img_path(), diskfather);
            //String path = FileUtil.getSavePath(ConfigReader.getUpload_img_path());
            System.out.println(path);
            String ori_fileName = file.getOriginalFilename();
            String md5_fileName = Md5Util.getFileMD5String(file.getInputStream()) + "."
                    + FileUtil.getExtensionName(ori_fileName);
            String Filetype = FileUtil.getExtensionName(ori_fileName);
            System.out.println("文件类型：" + Filetype);
            logger.info("path:" + path);
            logger.info("ori_fileName:" + ori_fileName);
            logger.info("md5_filename:" + md5_fileName);
            File targetFile = new File(path, md5_fileName);
            String diskuserid = diskDao.findOneByid(Diskfather).getDiskuserid();
            User user1=userDao.findOneById(diskuserid);
            if (!targetFile.exists()) {
                file.transferTo(targetFile);
                // 是否是图片
//				if (!isImage(targetFile)) {
//					targetFile.delete();
//					throw new UploadException(UploadError.FILE_ERROR);
//				}

                if (!userService.checkUserMemory(user1, (double) ((double) file.getSize() / (1024 * 1024)))) {
                    targetFile.delete();
                    throw new UploadException(UploadError.FILE_ERROR);
                }
                //是否是图片
                if (isImage(targetFile)) {
                    Filetype = "jpg";
                } else
                    //是否是视频
                    if (isVidio(Filetype)) {
                        Filetype = "mp4";
                    } else if (Isdoc(Filetype)) {
                        Filetype = "word";
                    } else if (Isxls(Filetype)) {
                        Filetype = "excl";
                    } else if (Isppt(Filetype)) {
                        Filetype = "ppt";
                    } else {
                        Filetype = "zip";
                    }


                Disk disk = new Disk();
                disk.setDiskuserid(user.getUserid());
                disk.setDiskname(ori_fileName);
                disk.setDiskfather(Diskfather);
                disk.setDisktype(Filetype);
                disk.setDisksize((double) ((double) file.getSize() / (1024 * 1024)));
                String p = path + md5_fileName;
                System.out.println("上传路径：" + p);
                disk.setPath(p);
                disk.setHavechild(0);
                disk.setHavefather(1);
                diskService.saveFile(disk);
                System.out.println(disk);
                user1.setMemory((double) (user1.getMemory() + ((double) file.getSize() / (1024 * 1024))));
                //更新增长内存
                userDao.updateMemory(user1);
                System.out.println(user1);
                um.setSuccess("true");
                um.setMsg(" 成功！ ");
                um.setOri_name(ori_fileName);
                um.setMd5_name(md5_fileName);
                um.setPath(p);


            } else {
                um.setSuccess("false");
                um.setMsg(" 上传失败！ 文件已存在!");
                //um.setOri_name(ori_fileName);
                //um.setMd5_name(md5_fileName);
            }


        } catch (Exception e) {
            logger.error(e);
            um.setSuccess("false");
            um.setMsg(" 上传失败！ " + e);
            //um.setOri_name(ori_fileName);
            //um.setMd5_name(md5_fileName);
        }
        logger.info("---------------- upload img end ---------------------");
        return um;
    }

    /**
     * 判断文件是否是图片
     *
     * @param file
     * @return
     * @throws IOException
     */
    private static boolean isImage(File file) throws IOException {
        BufferedImage bi = ImageIO.read(file);
        if (bi == null) {
            return false;
        }
        return true;
    }

    /**
     * 判断文件是否是视频音频
     *
     * @param type1
     * @return
     */
    private static boolean isVidio(String type1) {
        List<String> type = new ArrayList<>();
        type.add("avi");
        type.add("wmv");
        type.add("mpeg");
        type.add("mp4");
        type.add("mov");
        type.add("mkv");
        type.add("flv");
        type.add("mp4");
        type.add("f4v");
        type.add("m4v");
        type.add("rmvb");
        type.add("rm");
        type.add("flv");
        type.add("3gp");
        type.add("dat");
        type.add("ts");
        type.add("mts");
        type.add("vob");
        type.add("mp3");
        for (String t : type) {
            if (type1.equalsIgnoreCase(t))
                return true;
        }
        return false;

    }

    private static boolean Isdoc(String type1) {
        List<String> type = new ArrayList<>();
        type.add("doc");
        type.add("docx");
        for (String t : type) {
            if (type1.equalsIgnoreCase(t))
                return true;
        }
        return false;
    }

    private static boolean Isxls(String type1) {
        List<String> type = new ArrayList<>();
        type.add("xls");
        type.add("xlsx");
        for (String t : type) {
            if (type1.equalsIgnoreCase(t))
                return true;
        }
        return false;
    }

    private static boolean Isppt(String type1) {
        List<String> type = new ArrayList<>();
        type.add("ppt");
        type.add("pptx");
        for (String t : type) {
            if (type1.equalsIgnoreCase(t))
                return true;
        }
        return false;
    }


//	public static void main(String[] args) throws IOException {
//		System.out.println(isImage(new File("C:/Users/Administrator/Desktop/IMEGE/2015/4/29/1.png")));
//	}
}
