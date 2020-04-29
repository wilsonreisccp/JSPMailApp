<%-- 
    Document   : mailJSP
    Created on : 29/04/2020, 10:58:49
    Author     : wilson
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
<%
    String result;

    final String to = request.getParameter("mail");
    final String subject = request.getParameter("sub");
    final String messg = request.getParameter("mess");

    final String from = "email@gmail.com";
    final String pass = "senha";
    
    String host = "smtp.gmail.com";
    Properties props = new Properties();
    
    props.put("mail.smtp.port", 587);
    props.put("mail.smtp.host", host);
    props.put("mail.transport.protocol", "smtp");
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");
    props.put("mail.user", from);
    props.put("mail.password", pass);
    
    Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
        @Override
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(from, pass);
        }
    });

    try {
        MimeMessage message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress(from));
        message.addRecipient(Message.RecipientType.TO,
                new InternetAddress(to));
        // Set Subject: header field
        message.setSubject(subject);
        // Now set the actual message
        message.setText(messg);
        // Send message
        Transport.send(message);
        result = "Your mail sent successfully....";
    } catch (MessagingException mex) {
        mex.printStackTrace();
        result = "Error: unable to send mail....\n" + mex;
    }
%>
        <title>Sending Mail in JSP</title>
        <h1><center><font color="blue">Sending Mail Using JSP</font></h1>
        <b><center><font color="red"><% out.println(result);%></b>
    </body>
</html>
