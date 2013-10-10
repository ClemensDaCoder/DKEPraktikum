import java.io.IOException;

import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import org.xml.sax.ext.DefaultHandler2;
import org.xml.sax.helpers.XMLReaderFactory;



public class Splitter {
	
	public static void main(String [] args) throws SAXException, IOException {
		XMLReader xr =	XMLReaderFactory.createXMLReader();
		
		DefaultHandler2 dh = new DblpHandler();
		xr.setContentHandler(dh);
		xr.parse(new InputSource("D:/Uni/DKE Praktikum/dblp.xml"));
	}


}
