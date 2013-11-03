import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
class Test {

	public static void main (String [] args) throws XPathExpressionException, FileNotFoundException, SAXException, IOException {
		
		DocumentBuilderFactory builderFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = null;
		try {
		    builder = builderFactory.newDocumentBuilder();
		} catch (ParserConfigurationException e) {
		    e.printStackTrace();  
		}
		
		Document document = builder.parse(new FileInputStream("employees.xml"));
//		
//		String xml = ...;
//		Document xmlDocument = builder.parse(new ByteArrayInputStream(xml.getBytes()));
		
		XPath xPath =  XPathFactory.newInstance().newXPath();
		
//		String expression = "/Employees/Employee[@emplid='3333']/email";
		 
//		//read a string value
//		String email = xPath.compile(expression).evaluate(document);
//		 
//		//read an xml node using xpath
//		Node node = (Node) xPath.compile(expression).evaluate(document, XPathConstants.NODE);
//		 
//		//read a nodelist using xpath
//		NodeList nodeList = (NodeList) xPath.compile(expression).evaluate(document, XPathConstants.NODESET);
		
		
		String expressionFirstname = "/Employees/Employee/firstname";
		System.out.println(expressionFirstname);
		NodeList nodeListFirstName = (NodeList) xPath.compile(expressionFirstname).evaluate(document, XPathConstants.NODESET);
		for (int i = 0; i < nodeListFirstName.getLength(); i++) {
		    System.out.println(nodeListFirstName.item(i).getFirstChild().getNodeValue()); 
		}
	}
}
