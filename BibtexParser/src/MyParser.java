import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import javax.xml.XMLConstants;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.datatype.XMLGregorianCalendar;
import javax.xml.transform.Source;
import javax.xml.validation.SchemaFactory;

import mastersthesis.Mastersthesis;
import mastersthesis.Mastertheseses;
import mastersthesis.ObjectFactory;
import net.sf.jabref.BibtexDatabase;
import net.sf.jabref.BibtexEntry;
import net.sf.jabref.imports.BibtexParser;
import net.sf.jabref.imports.ParserResult;

import org.basex.server.ClientQuery;
import org.basex.server.ClientSession;
import org.xml.sax.SAXException;

import com.sun.org.apache.xerces.internal.jaxp.datatype.XMLGregorianCalendarImpl;

public class MyParser {

	//we don't care about exception handling for now
	public static void main(String[] args) throws IOException,
			SecurityException, NoSuchMethodException, IllegalArgumentException,
			IllegalAccessException, InvocationTargetException, JAXBException, SAXException {

		String s = "@mastersthesis{DBLP:mastersthesis/jku/kingofkingz1,"+
			"author = {M.K.M Weichselkaiserbaumreiter},"+
			"title = {Analyse der thermodynamischen Eigenschaften von IM},"+
			"year = {2014},"+
			"school = {JKU},"+
			"ee = {http://www.jku.at},"+
			"mdate = {2014-01-16},"+
			"key = {phd/Weichselkaiserbaumreiter1} }";
		
		new MyParser().addEntry(s);
	}
	
	public void addEntry(String bibtexAsString) throws IOException,
			SecurityException, NoSuchMethodException, IllegalArgumentException,
			IllegalAccessException, InvocationTargetException, JAXBException, SAXException{
		
//		//select file with bibtex content
//		FileReader bla = new FileReader("sample/masterthesis.bib");
//		ParserResult result = BibtexParser.parse(bla);
//		BibtexDatabase database = result.getDatabase();
		
		//create Objectfactory for parent & child elements
		ObjectFactory factory = new mastersthesis.ObjectFactory();
		Mastertheseses root = factory.createMastertheseses();
		
//		for (BibtexEntry e : database.getEntries()) {
		for (BibtexEntry e : BibtexParser.fromString(bibtexAsString)) {
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
		m.setSchema(sf.newSchema(new File("resources/mastersthesis.xsd")));
		//m.marshal(root, new File("sample/masterstheseses.xml"));
		StringWriter sw = new StringWriter();
		m.marshal(root, sw);
		
		String s = sw.toString();
		//remove processing instructions and root tags
		s=s.substring(s.indexOf("?>")+18, s.length()-17);
		System.out.println(s);
		
		//add masterthesis to database
		ClientSession session = new ClientSession("localhost", 1984, "admin", "admin");
		String queryString = "insert node" + s + " into db:open('dblpdatabase','masterthesis.xml')/dblp";
		ClientQuery query = session.query(queryString);
		query.execute();
	}
}