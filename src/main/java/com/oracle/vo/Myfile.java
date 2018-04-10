package com.oracle.vo;


public class Myfile {

  private long myfileid;
  private String userid;
  private long filediskid;

  @Override
  public String toString() {
    return "Myfile{" +
            "myfileid=" + myfileid +
            ", userid='" + userid + '\'' +
            ", filediskid=" + filediskid +
            '}';
  }

  public long getMyfileid() {
    return myfileid;
  }

  public void setMyfileid(long myfileid) {
    this.myfileid = myfileid;
  }


  public String getUserid() {
    return userid;
  }

  public void setUserid(String userid) {
    this.userid = userid;
  }


  public long getFilediskid() {
    return filediskid;
  }

  public void setFilediskid(long filediskid) {
    this.filediskid = filediskid;
  }

}
