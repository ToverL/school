package com.oracle.vo;


public class File {

  private long fileid;
  private String filename;

  @Override
  public String toString() {
    return "File{" +
            "fileid=" + fileid +
            ", filename='" + filename + '\'' +
            '}';
  }

  public long getFileid() {
    return fileid;
  }

  public void setFileid(long fileid) {
    this.fileid = fileid;
  }


  public String getFilename() {
    return filename;
  }

  public void setFilename(String filename) {
    this.filename = filename;
  }

}
