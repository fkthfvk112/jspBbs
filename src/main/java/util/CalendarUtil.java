package util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import dto.CalendarDto;

public class CalendarUtil {
	//문자열 검사(빈 문자열 -> true리턴)
	public static boolean nvl(String msg) {
		return msg == null || msg.trim().equals("");
	}
	
	//한 자리 숫자 -> 두 자리 숫자 : 1 -> 01
	public static String two(String msg) {
		return msg.trim().length() < 2? "0"+msg.trim():msg.trim();
	}
	
	//앞에 두 자리 문자형 숫자 -> 한자리 문자형 숫자
	public static String one(String msg) {
		return msg.charAt(0)=='0'?msg.charAt(1)+"":msg;
	}
	
	//일별 일정 모두 확인하는 caldaylist로 이동
	public static String daylist(int year, int month, int day) {
		String str = "";
		str += String.format("&nbsp;<a href='caldaylist.jsp?year=%d&month=%d&day=%d' style='color:black; text-decoration: none;'><b>",
				year, month, day);
		str += String.format("%2d", day);
		str += "</b></a>";
		
		return str;
	}
	
	public static String calwrite(int year, int month, int day) {
		
		String str = "";
		String img = "✏️ ";
		str = String.format("<a href ='calwrite.jsp?year=%d&month=%d&day=%d'  style='color:black; text-decoration: none;'>%s</a>", 
				year, month, day, img);
		
		return str;
	}
	
	//제목이 길 경우 ...으로 처리
	public static String dot3(String msg) {
		String str = "";
		if(msg.length() >= 10) {
			str = msg.substring(0, 10);//0~9
			str += "...";
		}
		else {
			str = msg.trim();
		}
		return str;
	}
	
	//날짜별로 테이블 생성
	public static String makeTable(int year, int month, int day, List<CalendarDto> list) {
		String str = "";
		String dates = (year + "") + two(month+"") + two(day+"");
		
		str += "<table>";
		for(CalendarDto dto:list) {
			if(dto.getRdate().substring(0, 8).equals(dates)) {
				str += "<tr>";
				str += "  <td style='padding:0px;'>";
				str += "	 <a href='caldetail.jsp?seq=" + dto.getSeq() + "'>";
				str += "		<font style='font-size:8px; color:blue;'>";
				str += 				dot3(dto.getTitle());
				str += "		</font>";
				str += "	 </a>";
				str += "  </td>";
				str += "</tr>";
			}
		}
		str += "</table>";
		
		return str;
	}
	
	//202307051030 -> 2023-07-05 10:29 -> 2023년 7월 5일 10:30
	public static String toDates(String mdate) {
		//날짜형식
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분");
		
		String s = mdate.substring(0, 4) + "-"
		        + mdate.substring(4, 6) + "-"
		        + mdate.substring(6, 8) + " "
		        + mdate.substring(8, 10) + ":"
		        + mdate.substring(10, 12) + ":00";
		
		Timestamp d = Timestamp.valueOf(s);
		
		return sdf.format(d);
	}
}
