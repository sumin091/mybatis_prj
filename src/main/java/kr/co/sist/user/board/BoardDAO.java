
package kr.co.sist.user.board;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import kr.co.sist.dao.MyBatisDAO;

public class BoardDAO {

	private static BoardDAO bDAO;
	private String[] columnNames;

	private BoardDAO() {
		columnNames = new String[] { "title", "content", "id" };
	}

	public static BoardDAO getInstance() {
		if (bDAO == null) {
			bDAO = new BoardDAO();
		} // end if
		return bDAO;
	}

	/*
	 * 총 레코드의 수
	 * 
	 * @param sVO
	 * 
	 * @return
	 * 
	 * @throws SQLException
	 */
	public int selectTotalCount(SearchVO sVO) throws PersistenceException {
		int totalCnt = 0;

		//1.MyBatis Handler 얻기
		MyBatisDAO mbDAO=MyBatisDAO.getInstance();
		SqlSession ss= mbDAO.getMybatisHandler(false);
		//2.쿼리문 실행
		totalCnt=ss.selectOne("kr.co.sist.board.selectTotalCount", sVO);
		//3.MyBatis Handelr 닫기
		mbDAO.closeHandler(ss);
		
		return totalCnt;
	}//selectTotalCount
	
	
	public List<BoardDomain> selectBoard(SearchVO sVO) throws PersistenceException {
		List<BoardDomain> list = null;
		
		//1.MyBatis Handler 얻기
		MyBatisDAO mbDao=MyBatisDAO.getInstance();
		SqlSession ss= mbDao.getMybatisHandler(false);
		//2.쿼리문 실행
		list=ss.selectList("kr.co.sist.board.selectBoardList",sVO);
		//3.MyBatis Handelr 닫기
		mbDao.closeHandler(ss);
		
				
		return list;
	}//selectBoard
	
//
	public void insertBoard(BoardVO bVO) throws PersistenceException {
		MyBatisDAO mbDAO=MyBatisDAO.getInstance();
		SqlSession ss= mbDAO.getMybatisHandler(true);//auto commit
		
		ss.insert("kr.co.sist.board.insertBoard",bVO);
		
		mbDAO.closeHandler(ss);

	}// insertBoard
	
//
	public BoardDomain selectDetailBoard(int seq) throws PersistenceException {
		BoardDomain bd= null;

		//1.MyBatis Handler 얻기
		MyBatisDAO mbDao=MyBatisDAO.getInstance();
		SqlSession ss= mbDao.getMybatisHandler(false);//auto commit
		//2.쿼리문 실행
		bd=ss.selectOne("kr.co.sist.board.selectDetailBoard",seq);//글을 조회
//		ss.update("kr.co.sist.board.updateCnt",seq);//조회수 증가
		//3.MyBatis Handelr 닫기
		mbDao.closeHandler(ss);
		return bd;
	}//selectDetailBoard

	
	public int updateCnt(int seq) throws PersistenceException {
		int cnt=0;
		
		//1.MyBatis Handler 얻기
		MyBatisDAO mbDAO=MyBatisDAO.getInstance();
		SqlSession ss= mbDAO.getMybatisHandler(true);//auto commit
		//2.쿼리문 실행
		cnt=ss.update("kr.co.sist.board.updateCnt",seq);//조회수 증가
		//3.MyBatis Handelr 닫기
		mbDAO.closeHandler(ss);
		return cnt;
	}//updateCnt
	
	public static void main(String[] args) {
//		SearchVO sVO= new SearchVO();
//		sVO.setField("2");
//		sVO.setKeyword("d");
//		sVO.setStartNum(1);
//		sVO.setEndNum(10);
//		BoardDAO.getInstance().selectBoard(sVO);
//		BoardVO bVO= new BoardVO(0,530,"마이바티스로 추가", "세상편함 생산성 오지고","kim", null );
		BoardDAO.getInstance().updateCnt(125);
	}//main
//	
	public int updateBoard(BoardVO bVO) throws PersistenceException {
		int cnt=0;
		
		//1.MyBatis Handler 얻기
		MyBatisDAO mbDAO=MyBatisDAO.getInstance();
		SqlSession ss= mbDAO.getMybatisHandler(true);//auto commit
		//2.쿼리문 실행
		cnt=ss.update("kr.co.sist.board.updateBoard",bVO);//조회수 증가
		//3.MyBatis Handelr 닫기
		mbDAO.closeHandler(ss);
		return cnt;
	}// updateBoard
//	
	public int deleteBoard(BoardVO bVO) throws PersistenceException {
		int cnt=0;
		
		//1.MyBatis Handler 얻기
		MyBatisDAO mbDAO=MyBatisDAO.getInstance();
		SqlSession ss= mbDAO.getMybatisHandler(true);//auto commit
		//2.쿼리문 실행
		cnt=ss.delete("kr.co.sist.board.deleteBoard",bVO);//조회수 증가
		//3.MyBatis Handelr 닫기
		mbDAO.closeHandler(ss);
		return cnt;
	}// deleteBoard
//	
//	public int updateCnt(int num) throws SQLException {
//		int cnt=0;
//		Connection con = null;
//		PreparedStatement pstmt = null;
//
//		DbConnection db = DbConnection.getInstance();
//
//		try {
//			// 1.JNDI 사용객체 생성
//			// 2.DataSource 얻기
//			// 3.Connection 얻기
//			con = db.getConn("jdbc/dbcp");
//			// 4.쿼리문 생성객체 얻기(Dynamic Query)
//			StringBuilder updateCnt = new StringBuilder();
//			updateCnt.append(" update board set cnt= cnt+1 ")
//			.append(" where num=? ");
//
//			pstmt = con.prepareStatement(updateCnt.toString());
//
//			// 바인드 변수 값 설정
//			pstmt.setInt(1, num);
//
//			cnt=pstmt.executeUpdate();
//
//		} finally {
//			// 7.연결끊기
//			db.closeCon(null, pstmt, con);
//		}
//		return cnt;
//	}// updateBoard
	
	
}// class
