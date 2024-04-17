<%@ page import="javax.xml.parsers.DocumentBuilderFactory, javax.xml.parsers.DocumentBuilder, org.w3c.dom.Document, org.w3c.dom.NodeList, org.w3c.dom.Node, org.w3c.dom.Element, java.io.File" %>
<!DOCTYPE html>
<html>
<head>
    <title>Online Examination</title>
</head>
<body>
    <h1>Online Examination Portal</h1>
    <%
    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    DocumentBuilder builder;
    try {
        String xmlPath = application.getRealPath("/WEB-INF/assignment.xml");
        builder = factory.newDocumentBuilder();
        Document document = builder.parse(new File(xmlPath));
        document.getDocumentElement().normalize();

        NodeList questions = document.getElementsByTagName("questions");
        out.println("<form action='result.jsp' method='POST'>");
        for (int i = 0; i < questions.getLength(); i++) {
            Node questionNode = questions.item(i);
            if (questionNode.getNodeType() == Node.ELEMENT_NODE) {
                Element questionElement = (Element) questionNode;
                String questionText = questionElement.getElementsByTagName("question").item(0).getTextContent();
                out.println("<div>");
                out.println("<p>" + questionText + "</p>");
                out.println("<input type='radio' name='userAnswer" + i + "' value='True'> True<br>");
                out.println("<input type='radio' name='userAnswer" + i + "' value='False'> False<br>");
                out.println("</div>");
            }
        }
        out.println("<button type='submit'>Submit Answers</button>");
        out.println("</form>");
    } catch (Exception e) {
        out.println("<p>Unable to load examination questions. Try again later.</p>");
    }
    %>
</body>
</html>
