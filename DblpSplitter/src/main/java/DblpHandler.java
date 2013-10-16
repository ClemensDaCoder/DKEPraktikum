import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.ext.DefaultHandler2;


/**
 * @author Michael Weichselbaumer
 * @autho Manuel Hochreiter
 *
 */
public class DblpHandler extends DefaultHandler2 {


	private StringBuffer nodeValue = new StringBuffer(1024);

	private FileOutputStream output;

	private Map<String, File> docTypes;

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.xml.sax.helpers.DefaultHandler#startDocument()
	 */
	@Override
	public void startDocument() {
		docTypes = new HashMap<String, File>();
		docTypes.put("article", new File("article.xml"));
		docTypes.put("book", new File("book.xml"));
		docTypes.put("incollection", new File("incollection.xml"));
		docTypes.put("inproceedings", new File("inproceedings.xml"));
		docTypes.put("masterthesis", new File("masterthesis.xml"));
		docTypes.put("phdthesis", new File("phdthesis.xml"));
		docTypes.put("proceedings", new File("proceedings.xml"));
		docTypes.put("publication", new File("publication.xml"));
		docTypes.put("www", new File("www.xml"));

		// delete existing xml files
		for (Map.Entry<String, File> d : docTypes.entrySet()) {
			d.getValue().delete();
		}
	}

	/**
	 * {@inheritDoc}
	 * <p>
	 * In case of an element interesting for us .. we do something
	 */
	@Override
	public void startElement(String uri, String name, String qName,	Attributes atts) {
		if (docTypes.get(name) != null) {
			newDocumentType(name, atts);
		} else {
			//for every element (all sub-elements) - just add to currently selected buffer
			nodeValue.append("<" + name + ">");
		}
	}

	private void newDocumentType(String name, Attributes atts) {
		//reset content of buffer
		nodeValue.setLength(0);
		//put element in buffer
		nodeValue.append("<" + name);
		// put attributes in buffer
		for (int i = 0; i < atts.getLength(); i++) {
			nodeValue.append(" " + atts.getLocalName(i) + "=\"" 	+ atts.getValue(i) + "\"");
		}
		nodeValue.append(">");
	}

	@Override
	public void endElement(String uri, String localName, String qName)
			throws SAXException {
		// add closing tag for current element
		nodeValue.append("</" + localName + ">");

		//if element is one of the "main elements" - write to appropiate file
		if (docTypes.get(localName) != null) {
			writeToFile(docTypes.get(localName));
		}
	}

	/**
	 * Appends content in {@code nodeValue} to {@code file} given as parameter.
	 * 
	 * @param file
	 *            content is appended to.
	 */
	private void writeToFile(File file) {
		nodeValue.append("\n");
		try {
			output = new FileOutputStream(file, true);
			output.write(nodeValue.toString().getBytes());
			nodeValue.setLength(0);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				output.close();
			} catch (IOException e) {
				// nothing to do here
			}
		}
	}

	/**
	 * {@inheritDoc}
	 * 
	 * @see org.xml.sax.helpers.DefaultHandler#characters(char[], int, int)
	 */
	@Override
	public void characters(char[] ch, int start, int length) throws SAXException {
		//write content of element into buffer
		nodeValue.append(ch, start, length);
	}
}
