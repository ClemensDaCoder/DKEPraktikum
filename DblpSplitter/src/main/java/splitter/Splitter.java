package splitter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXSource;
import javax.xml.transform.stream.StreamResult;

import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLFilter;
import org.xml.sax.XMLReader;
import org.xml.sax.ext.DefaultHandler2;
import org.xml.sax.helpers.XMLReaderFactory;

import splitter.filter.EeValidFilter;
import splitter.filter.IsbnValidFilter;
import splitter.filter.PagesFilter;
import splitter.filter.publication.ArticleFilter;
import splitter.filter.publication.BookFilter;
import splitter.filter.publication.InProceedingsFilter;
import splitter.filter.publication.IncollectionFilter;
import splitter.filter.publication.MasterthesisFilter;
import splitter.filter.publication.PhdThesisFilter;
import splitter.filter.publication.ProceedingsFilter;
import splitter.filter.publication.PublicationFilter;
import splitter.filter.publication.WwwFilter;


/** Splits dblp.xml file into several files (one per publication type). <p>
 * Publication types are: article, book, ... etc.
 * 
 * @author Michael Weichselbaumer
 *
 */
public class Splitter {
	
	public static void main(String [] args) throws SAXException, IOException, TransformerException, ParserConfigurationException {
//		InputSource dblpFile = new InputSource("test.xml");
		InputSource dblpFile = new InputSource("D:/Uni/DKE Praktikum/dblp.xml");
			
		splitDblpFile(dblpFile, new ArticleFilter(), new FileOutputStream("article.xml"));
		splitDblpFile(dblpFile, new BookFilter(), new FileOutputStream("book.xml"));
		splitDblpFile(dblpFile, new IncollectionFilter(), new FileOutputStream("incollection.xml"));
		splitDblpFile(dblpFile, new InProceedingsFilter(), new FileOutputStream("inproceedings.xml"));
		splitDblpFile(dblpFile, new MasterthesisFilter(), new FileOutputStream("masterthesis.xml"));
		splitDblpFile(dblpFile, new PhdThesisFilter(), new FileOutputStream("phdthesis.xml"));
		splitDblpFile(dblpFile, new ProceedingsFilter(), new FileOutputStream("proceedings.xml"));
		splitDblpFile(dblpFile, new WwwFilter(), new FileOutputStream("www.xml"));
	}
		
	/** Extracts all elements matching given  {@code publicationFilter} from  {@code dblpFile} into {@code splittedFile} 
	 * @param dblpFile
	 * @param publicationFilter
	 * @param splittedFile
	 * @throws SAXException
	 * @throws TransformerConfigurationException
	 * @throws TransformerException
	 * @throws ParserConfigurationException 
	 */
	public static void splitDblpFile(InputSource dblpFile, PublicationFilter publicationFilter, OutputStream splittedFile) throws SAXException, TransformerConfigurationException, TransformerException, ParserConfigurationException {
		SAXParserFactory saxFactory = SAXParserFactory.newInstance();
		SAXParser parser = saxFactory.newSAXParser();
		
//		XMLReader xr = parser.getXMLReader();
		
		DefaultHandler2 dh = new DefaultHandler2();
		//pagesFilter is for turning "pages" element into "from" and "to" elements
		XMLFilter pagesFilter = new PagesFilter();
		XMLFilter isbnFilter = new IsbnValidFilter();
		XMLFilter eeFilter = new EeValidFilter();
		XMLReader xr = XMLReaderFactory.createXMLReader();
		xr.setProperty("http://xml.org/sax/properties/lexical-handler", new UmlautHandler());

//		publicationFilter.setProperty("http://xml.org/sax/properties/lexical-handler", new UmlautHandler());
		publicationFilter.setContentHandler(dh);
		publicationFilter.setParent(xr);
		pagesFilter.setParent(publicationFilter);
		isbnFilter.setParent(pagesFilter);
		eeFilter.setParent(isbnFilter);
		
		//Now let's throw in a transformer to fix this problem: http://www.dragishak.com/?p=131
		StreamResult result = new StreamResult(splittedFile);
		TransformerFactory transformerFactory = TransformerFactory.newInstance("com.sun.org.apache.xalan.internal.xsltc.trax.TransformerFactoryImpl", Splitter.class.getClassLoader());
		SAXSource transformSource = new SAXSource(eeFilter, dblpFile);
		transformerFactory.newTransformer().transform(transformSource, result);
	}


}
