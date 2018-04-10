package com.oracle.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import com.oracle.vo.User;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.WorkbookSettings;
import jxl.read.biff.BiffException;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.ss.usermodel.DateUtil;

import static org.apache.poi.ss.usermodel.Cell.CELL_TYPE_NUMERIC;

public class ReadExcel {

    // 去读Excel的方法readExcel，该方法的入口参数为一个File对象
    public List<User> readExcel(File file) {
        try {
            // 创建输入流，读取Excel
            InputStream is = new FileInputStream(file.getAbsolutePath());
            // jxl提供的Workbook类

            WorkbookSettings workbookSettings = new WorkbookSettings();
            workbookSettings.setEncoding("gbk");
            Workbook wb = Workbook.getWorkbook(is,workbookSettings);
            // Excel的页签数量
            int sheet_size = wb.getNumberOfSheets();
            for (int index = 0; index < sheet_size; index++) {
                List<User> userList=new ArrayList<>();
                // 每个页签创建一个Sheet对象
                Sheet sheet = wb.getSheet(index);
                // sheet.getRows()返回该页的总行数
                for (int i = 1; i < sheet.getRows(); i++) {
                    // sheet.getColumns()返回该页的总列数
                    User user = new User();
                    for (int j = 0; j < sheet.getColumns(); j++) {
                        String cellinfo= sheet.getCell(j, i).getContents();
                        if(cellinfo.isEmpty()){
                            continue;
                        }
                        switch (j){
                            case 0 :user.setUserid(cellinfo);break;
                            case 1 :user.setPassword(cellinfo);break;
                            case 2 :user.setWorkschool(cellinfo);break;
                            case 3 :user.setName(cellinfo);break;
                            case 4 :user.setSex(cellinfo);break;
                            case 5 :user.setNation(cellinfo);break;
                            case 6 :cellinfo="20"+cellinfo;user.setWorktime(Date.valueOf(cellinfo));break;
                            case 7 :user.setWentichenxu(cellinfo);break;
                            case 8 :user.setZhiwu(cellinfo);break;
                            case 9 :user.setZhichen(cellinfo);break;
                            case 10 :user.setZhuanrenjiaoshi(cellinfo);break;
                            case 11 :user.setKemu(cellinfo);break;
                            case 12 :user.setNianji(cellinfo);break;
                            case 13 :user.setBanji(cellinfo);break;
                            case 14 :user.setBanzhuren(cellinfo);break;
                            case 15 :user.setPhone(cellinfo);break;
                            case 16 :user.setTip(cellinfo);break;
                            case 17 :user.setShenfen(cellinfo);break;
                            case 18 :user.setFenzu(cellinfo);break;
                            case 19 :user.setMemoryflag(Integer.parseInt(cellinfo));break;
                        }
                    }
                    userList.add(user);
                }
                return userList;
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (BiffException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
