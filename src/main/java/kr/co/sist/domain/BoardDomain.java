package kr.co.sist.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@NoArgsConstructor
@Setter
@Getter
@ToString
public class BoardDomain {

	private int num, cnt;
	private String title, content, id;
	private Date input_date;
}
