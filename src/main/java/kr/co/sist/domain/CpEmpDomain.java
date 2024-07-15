package kr.co.sist.domain;

import java.sql.Date;

//@NoArgsConstructor
//@AllArgsConstructor
//@Getter
//@Setter
//@ToString

public class CpEmpDomain {
	private int empno, sal, comm, deptno;	//ctrl+shift+y 소문자, ctrl+shift+x 대문자 
	private String ename, hiredateStr, job;
	private Date hiredate;
	
	
	public CpEmpDomain() {
		System.out.println("CpEmpDomain 기본생성자");
	}
	
	


	public CpEmpDomain(int empno, int sal, int comm, int deptno, String ename, String hiredateStr, String job,
			Date hiredate) {
		super();
		this.empno = empno;
		this.sal = sal;
		this.comm = comm;
		this.deptno = deptno;
		this.ename = ename;
		this.hiredateStr = hiredateStr;
		this.job = job;
		this.hiredate = hiredate;
	}




	public int getEmpno() {
		return empno;
	}


	
	public void setEmpno(int empno) {
		
		this.empno = empno;
	}


	public int getSal() {
		return sal;
	}


	public void setSal(int sal) {
		this.sal = sal;
	}


	
	public int getComm() {
		return comm;
	}


	
	public void setComm(int comm) {
		this.comm = comm;
	}


	public int getDeptno() {
		return deptno;
	}


	
	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}


	
	public String getEname() {
		return ename;
	}


	
	public void setEname(String ename) {
		System.out.println("setEName 설정값"+ename);
		this.ename = ename;
	}


	public String getHiredateStr() {
		return hiredateStr;
	}


	
	public void setHiredateStr(String hiredateStr) {
		this.hiredateStr = hiredateStr;
	}


	public String getJob() {
		return job;
	}


	
	public void setJob(String job) {
		this.job = job;
	}


	public Date getHiredate() {
		return hiredate;
	}


	
	public void setHiredate(Date hiredate) {
		this.hiredate = hiredate;
	}




	@Override
	public String toString() {
		return "CpEmpDomain [empno=" + empno + ", sal=" + sal + ", comm=" + comm + ", deptno=" + deptno + ", ename="
				+ ename + ", hiredateStr=" + hiredateStr + ", job=" + job + ", hiredate=" + hiredate + "]";
	}
	
	
}
