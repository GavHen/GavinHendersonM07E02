<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Addition Quiz</title>
</head>
<body>
    <h1>Addition Quiz</h1>
    
    <%-- Generate random addition questions and store them in session --%>
    <%
        int numQuestions = 5;
        int[] numbers = new int[numQuestions * 2]; // 2 numbers for each question
        int[] answers = new int[numQuestions]; // Store correct answers
        for (int i = 0; i < numQuestions; i++) {
            int num1 = (int) (Math.random() * 100); // Generate random numbers
            int num2 = (int) (Math.random() * 100);
            numbers[i * 2] = num1;
            numbers[i * 2 + 1] = num2;
            answers[i] = num1 + num2;
        }
        session.setAttribute("numbers", numbers);
        session.setAttribute("answers", answers);
        session.setAttribute("numQuestions", numQuestions);
        session.setAttribute("score", 0); // Initialize score
        session.setAttribute("answered", 0); // Initialize answered count
    %>
    
    <form action="quiz.jsp" method="post">
        <%-- Display quiz questions --%>
        <%
            int[] numbers = (int[]) session.getAttribute("numbers");
            int numQuestions = (int) session.getAttribute("numQuestions");
            for (int i = 0; i < numQuestions; i++) {
        %>
            <p>Question <%= i + 1 %>: <%= numbers[i * 2] %> + <%= numbers[i * 2 + 1] %> = 
                <input type="number" name="answer<%= i + 1 %>" required>
            </p>
        <% } %>
        
        <input type="submit" value="Submit">
    </form>
    
    <%-- Process user input and display result --%>
    <%
        if (request.getMethod().equals("POST")) {
            int[] answers = (int[]) session.getAttribute("answers");
            int numQuestions = (int) session.getAttribute("numQuestions");
            int score = 0;
            int answered = 0;
            for (int i = 0; i < numQuestions; i++) {
                String userAnswerStr = request.getParameter("answer" + (i + 1));
                if (userAnswerStr != null && !userAnswerStr.isEmpty()) {
                    int userAnswer = Integer.parseInt(userAnswerStr);
                    if (userAnswer == answers[i]) {
                        score++;
                    }
                    answered++;
                }
            }
            session.setAttribute("score", score);
            session.setAttribute("answered", answered);
        }
    %>
    
    <%-- Display quiz result --%>
    <%
        int score = (int) session.getAttribute("score");
        int answered = (int) session.getAttribute("answered");
        if (answered == numQuestions) {
    %>
        <h2>Quiz Result:</h2>
        <p>Score: <%= score %> / <%= numQuestions %></p>
    <% } %>
</body>
</html>