package kr.co.sist.dao;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MyBatisDAO {
	
	private static  MyBatisDAO mbDAO;
	private static SqlSessionFactory ssf;	//singleton 사용권장 => 비용절감,일관성유지
	
	private MyBatisDAO() {
		org.apache.ibatis.logging.LogFactory.useLog4J2Logging();
	}
	
	public static MyBatisDAO getInstance() {
		if(mbDAO == null) {
			mbDAO= new MyBatisDAO();
		}
		return mbDAO;
	}//getInstance()
	
	/**
	 * SqlSessionFactory는 비용절감, 일관성유지, 관리의 용이성을 위해서 Singleton pattern 으로 사용
	 * @return SqlSessionFactory
	 */
	
	static { //static 영역: 호출하지 않고 클래스가 생성되면 자동 호출되는 영역, 프로그램 실행시 1번만 호출, method를 사용하지 않을 경우라면
	
//	private static SqlSessionFactory getSessionFactory() {
		
		if(ssf == null) {
			try {
				//1.설정파일과 연결
				Reader reader= Resources.getResourceAsReader("kr/co/sist/dao/mybatis-config.xml");
				//2.Mybatis Framework 생성
				ssf= new SqlSessionFactoryBuilder().build(reader);
				//3.스트림 닫기
				if(reader != null) {reader.close();}//end if
			} catch (IOException e) {
				e.printStackTrace();
			}//end catch
		}//end if
	
		//return ssf;
		
	}// static 영역  getSesseionFactory
	
	public SqlSession getMybatisHandler(boolean autoCommit) {
		
		//SqlSession ss= null;
		//ss=/*getSessionFactory()*/ssf.openSession(autoCommit);
		return ssf.openSession(autoCommit);
	}
	
	public void closeHandler(SqlSession ss) {
		if(ss != null) {ss.close();}
	}
	
	
}
