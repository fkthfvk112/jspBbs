<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String seqS = request.getParameter("seq");
CalendarDao dao = CalendarDao.getInstance();
CalendarDto dto = null;

dto = dao.getCalender(Integer.parseInt(seqS));
response.setCharacterEncoding("UTF-8");

String jsonString = String.format("{\"wdate\":\"%s\", \"title\":\"%s\", \"content\":\"%s\"}", dto.getWdate(), dto.getTitle(), dto.getContent());

out.print(jsonString);

%>