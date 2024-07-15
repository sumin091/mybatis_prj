package kr.co.sist.user.board;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString

public class SearchVO {
	private String field, keyword, currentPage;
	private int startNum, endNum;
}
