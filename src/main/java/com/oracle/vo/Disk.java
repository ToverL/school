package com.oracle.vo;


public class Disk {

  private long diskid;
  private String diskuserid;
  private String disktype;
  private String diskname;
  private long diskfather;
  private double disksize;
  private long disklen=0;
  private String permission;
  private java.sql.Timestamp createtime;
  private String path="";
  private  int havechild=0;
  private int havefather=0;

  public int getHavefather() {
    return havefather;
  }

  public void setHavefather(int havefather) {
    this.havefather = havefather;
  }

  public int getHavechild() {
    return havechild;
  }

  public void setHavechild(int havechild) {
    this.havechild = havechild;
  }

  public String getPath() {
    return path;
  }

  public void setPath(String path) {
    this.path = path;
  }

  public long getDiskid() {
    return diskid;
  }

  public void setDiskid(long diskid) {
    this.diskid = diskid;
  }


  public String getDiskuserid() {
    return diskuserid;
  }

  public void setDiskuserid(String diskuserid) {
    this.diskuserid = diskuserid;
  }


  public String getDisktype() {
    return disktype;
  }

  public void setDisktype(String disktype) {
    this.disktype = disktype;
  }


  public String getDiskname() {
    return diskname;
  }

  public void setDiskname(String diskname) {
    this.diskname = diskname;
  }


  public long getDiskfather() {
    return diskfather;
  }

  public void setDiskfather(long diskfather) {
    this.diskfather = diskfather;
  }


  public double getDisksize() {
    return disksize;
  }

  public void setDisksize(double disksize) {
    this.disksize = disksize;
  }


  public long getDisklen() {
    return disklen;
  }

  public void setDisklen(long disklen) {
    this.disklen = disklen;
  }


  public String getPermission() {
    return permission;
  }

  public void setPermission(String permission) {
    this.permission = permission;
  }


  public java.sql.Timestamp getCreatetime() {
    return createtime;
  }

  public void setCreatetime(java.sql.Timestamp createtime) {
    this.createtime = createtime;
  }

  @Override
  public String toString() {
    return "Disk{" +
            "diskid=" + diskid +
            ", diskuserid='" + diskuserid + '\'' +
            ", disktype='" + disktype + '\'' +
            ", diskname='" + diskname + '\'' +
            ", diskfather=" + diskfather +
            ", disksize=" + disksize +
            ", disklen=" + disklen +
            ", permission='" + permission + '\'' +
            ", createtime=" + createtime +
            ", path='" + path + '\'' +
            ", havechild=" + havechild +
            ", havefather=" + havefather +
            '}';
  }
}
