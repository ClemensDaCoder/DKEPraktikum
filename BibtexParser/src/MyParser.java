import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import javax.xml.XMLConstants;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.datatype.XMLGregorianCalendar;
import javax.xml.validation.SchemaFactory;

import mastersthesis.Mastersthesis;
import mastersthesis.Mastertheseses;
import mastersthesis.ObjectFactory;
import net.sf.jabref.BibtexDatabase;
import net.sf.jabref.BibtexEntry;
import net.sf.jabref.imports.BibtexParser;
import net.sf.jabref.imports.ParserResult;

import org.xml.sax.SAXException;

import com.sun.org.apache.xerces.internal.jaxp.datatype.XMLGregorianCalendarImpl;

public class MyParser {

	//we don't care about exception handling for now
	public static void main(String[] args) throws IOException,
			SecurityException, NoSuchMethodException, IllegalArgumentException,
			IllegalAccessException, InvocationTargetException, JAXBException, SAXException {
		
		//select file with bibtex content
		FileReader bla = new FileReader("sample/masterthesis.bib");
		ParserResult result = BibtexParser.parse(bla);
		BibtexDatabase database = result.getDatabase();
		

		//create Objectfactory for parent & child elements
		ObjectFactory factory = new mastersthesis.ObjectFactory();
		Mastertheseses root = factory.createMastertheseses();
		
		for (BibtexEntry e : database.getEntries()) {
			System.out.println(e.getType().getName());
			Mastersthesis mastersThesis = factory.createMastersthesis();

			//use of reflection to identify necessary setters
			for (Method m : mastersThesis.getClass().getDeclaredMethods()) {
				// if return type is void - aka this is a setter method
				if (m.getReturnType().equals(void.class)) {
					String methodName = m.getName();
					String methodFieldName = methodName.substring(3).toLowerCase();
					String fieldValue = e.getField(methodFieldName);
					if (fieldValue != null) {
						//special treatment for year and mdate as they are not of type String
						if (methodFieldName.equalsIgnoreCase("year") || methodFieldName.equalsIgnoreCase("mdate")) { 
							XMLGregorianCalendar calendar =  XMLGregorianCalendarImpl.parse(fieldValue);
							m.invoke(mastersThesis, calendar);						
						} else {							
							m.invoke(mastersThesis, fieldValue);
						}
					}
				}
			}
			//add one entry to root 
			root.getMastersthesis().add(mastersThesis);
		}
		
		JAXBContext context = JAXBContext.newInstance(Mastertheseses.class);
		Marshaller m = context.createMarshaller();
		SchemaFactory sf = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
		m.setSchema(sf.newSchema(new File("schema/mastersthesis.xsd")));
		m.marshal(root, new File("sample/masterstheseses.xml"));
	}
}