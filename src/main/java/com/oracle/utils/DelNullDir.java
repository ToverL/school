package com.oracle.utils;

import org.junit.Test;

import java.io.*;
import java.util.Properties;

public  class DelNullDir {

  private void ShowDir(File file){
        for (File file1:file.listFiles()){
            if (file1.isDirectory()){
                ShowDir(file1);
                if (file1.listFiles().length==0){
                    file1.delete();
                }
            }
        }
    }


    public void deleteNullDir(){
        Properties properties=new Properties();
        try {
            properties.load(this.getClass().getClassLoader().getResourceAsStream("path_config.properties"));
            String path =properties.getProperty("upload_img_path");
            File file=new File(path);
            new DelNullDir().ShowDir(file);
        }catch (Exception e){
            e.printStackTrace();
        }

    }

}
