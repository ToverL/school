package com.oracle.config;

public class UploadException extends Exception{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String errCode = "";

	private String errReason = "";

	public void setErrCode(String errCode) {
		this.errCode = errCode;
	}

	public void setErrReason(String errReason) {
		this.errReason = errReason;
	}

	public String getErrCode() {
		return errCode;
	}

	public String getErrReason() {
		return errReason;
	}

	public UploadException(String errCode, String errReason) {
		super("[" + errCode + "]" + errReason);
		this.errCode = errCode;
		this.errReason = errReason;
	}

	public UploadException(String msg) {
		super(msg);
	}

	public UploadException(UploadError trpError) {
		// DATA_ACCESS_FAIL("011053", "系统内部错误"),
		super("[" + trpError.getCode() + "]" + trpError.getReason());
		this.errCode = trpError.getCode();
		this.errReason = trpError.getReason();

	}

	public UploadException(String errCode2, Exception e) {
		super(errCode2, e);
	}
}
