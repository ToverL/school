package com.oracle.vo;


public class User {

  private String userid;
  private String password;
  private String workschool;
  private String name;
  private String sex;
  private String nation;
  private java.sql.Date worktime;
  private String wentichenxu;
  private String zhiwu;
  private String zhichen;
  private String zhuanrenjiaoshi;
  private String kemu;
  private String nianji;
  private String banji;
  private String banzhuren;
  private String phone;
  private String tip;
  private String shenfen;
  private int havelist=0;
  private String fenzu;
  private   double memory=0;
  private   double memoryflag=500;
  private int laterdisk=-2;

  public int getLaterdisk() {
    return laterdisk;
  }

  public void setLaterdisk(int laterdisk) {
    this.laterdisk = laterdisk;
  }

  public double getMemoryflag() {
    return memoryflag;
  }

  public void setMemoryflag(double memoryflag) {
    this.memoryflag = memoryflag;
  }

  public double getMemory() {
    return memory;
  }

  public void setMemory(double memory) {
    this.memory = memory;
  }

  public String getFenzu() {
    return fenzu;
  }

  public void setFenzu(String fenzu) {
    this.fenzu = fenzu;
  }

  public int getHavelist() {
    return havelist;
  }

  public void setHavelist(int havelist) {
    this.havelist = havelist;
  }

  public String getUserid() {
    return userid;
  }

  public void setUserid(String userid) {
    this.userid = userid;
  }


  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }


  public String getWorkschool() {
    return workschool;
  }

  public void setWorkschool(String workschool) {
    this.workschool = workschool;
  }


  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }


  public String getSex() {
    return sex;
  }

  public void setSex(String sex) {
    this.sex = sex;
  }


  public String getNation() {
    return nation;
  }

  public void setNation(String nation) {
    this.nation = nation;
  }


  public java.sql.Date getWorktime() {
    return worktime;
  }

  public void setWorktime(java.sql.Date worktime) {
    this.worktime = worktime;
  }


  public String getWentichenxu() {
    return wentichenxu;
  }

  public void setWentichenxu(String wentichenxu) {
    this.wentichenxu = wentichenxu;
  }


  public String getZhiwu() {
    return zhiwu;
  }

  public void setZhiwu(String zhiwu) {
    this.zhiwu = zhiwu;
  }


  public String getZhichen() {
    return zhichen;
  }

  public void setZhichen(String zhichen) {
    this.zhichen = zhichen;
  }


  public String getZhuanrenjiaoshi() {
    return zhuanrenjiaoshi;
  }

  public void setZhuanrenjiaoshi(String zhuanrenjiaoshi) {
    this.zhuanrenjiaoshi = zhuanrenjiaoshi;
  }


  public String getKemu() {
    return kemu;
  }

  public void setKemu(String kemu) {
    this.kemu = kemu;
  }


  public String getNianji() {
    return nianji;
  }

  public void setNianji(String nianji) {
    this.nianji = nianji;
  }


  public String getBanji() {
    return banji;
  }

  public void setBanji(String banji) {
    this.banji = banji;
  }


  public String getBanzhuren() {
    return banzhuren;
  }

  public void setBanzhuren(String banzhuren) {
    this.banzhuren = banzhuren;
  }


  public String getPhone() {
    return phone;
  }

  public void setPhone(String phone) {
    this.phone = phone;
  }


  public String getTip() {
    return tip;
  }

  public void setTip(String tip) {
    this.tip = tip;
  }


  public String getShenfen() {
    return shenfen;
  }

  public void setShenfen(String shenfen) {
    this.shenfen = shenfen;
  }

  @Override
  public String toString() {
    return "User{" +
            "userid='" + userid + '\'' +
            ", password='" + password + '\'' +
            ", workschool='" + workschool + '\'' +
            ", name='" + name + '\'' +
            ", sex='" + sex + '\'' +
            ", nation='" + nation + '\'' +
            ", worktime=" + worktime +
            ", wentichenxu='" + wentichenxu + '\'' +
            ", zhiwu='" + zhiwu + '\'' +
            ", zhichen='" + zhichen + '\'' +
            ", zhuanrenjiaoshi='" + zhuanrenjiaoshi + '\'' +
            ", kemu='" + kemu + '\'' +
            ", nianji='" + nianji + '\'' +
            ", banji='" + banji + '\'' +
            ", banzhuren='" + banzhuren + '\'' +
            ", phone='" + phone + '\'' +
            ", tip='" + tip + '\'' +
            ", shenfen='" + shenfen + '\'' +
            ", havelist='" + havelist + '\'' +
            ", fenzu='" + fenzu + '\'' +
            ", memory=" + memory +
            ", memoryflag=" + memoryflag +
            ", laterdisk=" + laterdisk +
            '}';
  }
}
