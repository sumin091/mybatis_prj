package kr.co.sist.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class CarDomain {
	private int price;
	private String country,maker,model,car_year,car_option,car_img;
	private Date hiredate;
}
