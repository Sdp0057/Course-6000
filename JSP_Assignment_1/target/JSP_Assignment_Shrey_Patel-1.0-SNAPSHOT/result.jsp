<%@ page import="javax.xml.parsers.DocumentBuilderFactory, javax.xml.parsers.DocumentBuilder, org.w3c.dom.Document, org.w3c.dom.NodeList, org.w3c.dom.Node, org.w3c.dom.Element, java.io.File" %>
<!DOCTYPE html>
<html>
<head>
    <title>Exam Results</title>
</head>
<body>
    <h1>Results of Your Examination</h1>
    <%
    int totalScore = 0;
    int questionCount = 0;

    try {
        String xmlFile = application.getRealPath("/WEB-INF/assignment.xml");
        File xmlSource = new File(xmlFile);
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.parse(xmlSource);
        doc.getDocumentElement().normalize();

        NodeList questionsList = doc.getElementsByTagName("questions");
        questionCount = questionsList.getLength();

        for (int i = 0; i < questionCount; i++) {
            Node questionNode = questionsList.item(i);
            if (questionNode.getNodeType() == Node.ELEMENT_NODE) {
                Element questionElement = (Element) questionNode;
                String questionText = questionElement.getElementsByTagName("question").item(0).getTextContent();
                String correctAnswer = questionElement.getElementsByTagName("answer").item(0).getTextContent();
                String userAnswer = request.getParameter("userAnswer" + i);
                boolean correct = response != null && Boolean.parseBoolean(userAnswer) == Boolean.parseBoolean(correctAnswer);
                if (correct) {
                    totalScore++;
                }
                out.println("<div>");
                out.println("<p>Question " + (i + 1) + ": " + questionText + "</p>");
                out.println("<p>Your answer: " + (userAnswer != null ? userAnswer : "No response") + "</p>");
                out.println("<p>Result: " + (correct ? "Correct" : "Incorrect") + "</p>");
                if (!correct) {
                    out.println("<p>The correct answer was: " + correctAnswer + "</p>");
                }
                out.println("</div>");
            }
        }

        out.println("<p><strong>Your score: " + totalScore + " out of " + questionCount + "</strong></p>");
    } catch (Exception e) {
        out.println("Error processing exam results. Please try again or contact the administrator.");
        e.printStackTrace();
    }
    %>
    <a href='index.jsp'>Retake the exam</a>
</body>
</html>
