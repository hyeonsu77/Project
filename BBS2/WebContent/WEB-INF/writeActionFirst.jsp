<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.util.Enumeration"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String uploadPath=request.getRealPath("/upload");
	
int size = 10*1024*1024;
String bbsTitle="";
String bbsContent="";
String bbsFilename="";

	
try{
    MultipartRequest multi=new MultipartRequest(request,uploadPath,size,"UTF-8",new DefaultFileRenamePolicy());
    bbsTitle=multi.getParameter("bbsTitle");
    bbsContent=multi.getParameter("subject");
    bbsFilename=multi.getParameter("bbsFilename");
    Enumeration files = multi.getFileNames();
    String file1 = (String)files.nextElement();
    bbsFilename = multi.getFilesystemName(bbsFilename);
    String file2 = (String)files.nextElement();
    
}catch(Exception e){
    e.printStackTrace();
}
%>
<body onload="document.filecheck.onsubmit();">
<form name="filecheck" action="writeAction.jsp" method="post">
    <input type="hidden" name="bbsTitle" value="<%=bbsTitle %>">
    <input type="hidden" name="bbsContent" value="<%=bbsContent %>">
    <input type="hidden" name="bbsFilename" value="<%=bbsFilename %>">
</form>
</body>
</html>