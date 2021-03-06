import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import javax.xml.XMLConstants;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.datatype.XMLGregorianCalendar;
import javax.xml.validation.SchemaFactory;

import mastersthesis.Mastersthesis;
import mastersthesis.ObjectFactory;
import net.sf.jabref.BibtexEntry;
import net.sf.jabref.imports.BibtexParser;

import org.basex.server.ClientQuery;
import org.basex.server.ClientSession;
import org.xml.sax.SAXException;

import com.sun.org.apache.xerces.internal.jaxp.datatype.XMLGregorianCalendarImpl;

public class MyParser {

	// we don't care about exception handling for now
	public static void main(String[] args) throws IOException,
			SecurityException, NoSuchMethodException, IllegalArgumentException,
			IllegalAccessException, InvocationTargetException, JAXBException,
			SAXException {

		String s = "@mastersthesis{DBLP:mastersthesis/jku/kingofkingz1,"
				+ "author = {M.K.M Weichselkaiserbaumreiter},"
				+ "title = {Analyse der thermodynamischen Eigenschaften von IM},"
				+ "year = {2014}," + "school = {JKU},"
				+ "ee = {http://www.jku.at}," + "mdate = {2014-01-16},"
				+ "key = {phd/Weichselkaiserbaumreiter1} }";

		new MyParser().addEntry(s);
	}

	public void addEntry(String bibtexAsString) throws IOException,
			SecurityException, NoSuchMethodException, IllegalArgumentException,
			IllegalAccessException, InvocationTargetException, JAXBException,
			SAXException {

		// //select file with bibtex content
		// FileReader bla = new FileReader("sample/masterthesis.bib");
		// ParserResult result = BibtexParser.parse(bla);
		// BibtexDatabase database = result.getDatabase();

		// create Objectfactory for parent & child elements
		ObjectFactory factory = new mastersthesis.ObjectFactory();
		List<Mastersthesis> root = new ArrayList<Mastersthesis>();

		// for (BibtexEntry e : database.getEntries()) {
		for (BibtexEntry e : BibtexParser.fromString(bibtexAsString)) {
			System.out.println(e.getType().getName());
			Mastersthesis mastersThesis = factory.createMastersthesis();

			// use of reflection to identify necessary setters
			for (Method m : mastersThesis.getClass().getDeclaredMethods()) {
				// if return type is void - aka this is a setter method
				if (m.getReturnType().equals(void.class)) {
					String methodName = m.getName();
					String methodFieldName = methodName.substring(3)
							.toLowerCase();
					String fieldValue = e.getField(methodFieldName);
					if (fieldValue != null) {
						// special treatment for year and mdate as they are not
						// of type String
						if (methodFieldName.equalsIgnoreCase("year")
								|| methodFieldName.equalsIgnoreCase("mdate")) {
							XMLGregorianCalendar calendar = XMLGregorianCalendarImpl
									.parse(fieldValue);
							m.invoke(mastersThesis, calendar);
						} else {
							m.invoke(mastersThesis, fieldValue);
						}
					} else {
						throw new NoSuchMethodException("No value has been given for " + methodFieldName);
					}
				}
			}
			// add one entry to root
			root.add(mastersThesis);
		}

		JAXBContext context = JAXBContext.newInstance(Mastersthesis.class);
		Marshaller m = context.createMarshaller();
		SchemaFactory sf = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
		m.setSchema(sf.newSchema(new File("resources/mastersthesis.xsd")));
		// m.marshal(root, new File("sample/masterstheseses.xml"));
		
		// add masterthesis to database
		ClientSession session = new ClientSession("localhost", 1984, "admin", "admin");
		for (Mastersthesis thesis : root) {
			StringWriter sw = new StringWriter();
			m.marshal(thesis, sw);
			
			String s = sw.toString();
			s = s.substring(s.indexOf("?>")+2);
			System.out.println(s);
			
			String queryString = "insert node" + s + " into db:open('dblpdatabase','masterthesis.xml')/dblp";
			ClientQuery query = session.query(queryString);
			query.execute();
			
		}		
	}
}