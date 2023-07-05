package util;

public class BbsUtil {
	public static String titleDot(String title) {
		String newTitle;
		if(title.length()>=40) {
			newTitle = title.substring(0, 40);
			newTitle += "...";
		}
		else {
			newTitle = title.trim();
		}
		
		return newTitle;
	}
	
	//답글의 화살표
	public static String arrow(int depth) {
		String img = "<span>➔</span>";
		String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";
		
		String ts = "";
		for(int i = 0; i< depth; i++) {
			ts += nbsp;
		}
		return depth == 0?"":ts+img;
	}
}
