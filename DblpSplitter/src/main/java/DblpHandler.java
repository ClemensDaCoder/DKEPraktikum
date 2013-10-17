

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import model.Article;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.ext.DefaultHandler2;

/**
 * @author Manuel
 *
 */
public class DblpHandler extends DefaultHandler2 {

	private Article article;
	private List<Article> articles;
	
	private StringBuffer document = new StringBuffer(1024);
	
	private FileOutputStream output;
	
	private Map<String, String> docTypes;
	
	/*
	 * (non-Javadoc)
	 * 
	 * @see org.xml.sax.helpers.DefaultHandler#startDocument()
	 */
	@Override
	public void startDocument() {
		docTypes = new HashMap<String, String>();
		docTypes.put("article","article.xml");
		docTypes.put("book", "book.xml");
		docTypes.put("incollection","incollection.xml");
		docTypes.put("inproceedings","inproceedings.xml");
		docTypes.put("masterthesis","masterthesis.xml");
		docTypes.put("phdthesis","phdthesis.xml");
		docTypes.put("proceedings","proceedings.xml");
		docTypes.put("publication","publication.xml");
		docTypes.put("www","www.xml");
		
		//delete existing xml files
		for(Map.Entry<String, String> d: docTypes.entrySet()){
			File f = new File(d.getValue());
			f.delete();
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.xml.sax.helpers.DefaultHandler#endDocument()
	 */
	@Override
	public void endDocument() {

	}

	/**
	 * {@inheritDoc}
	 * <p>
	 * In case of an element interesting for us .. we do something
	 */
	@Override
	public void startElement(String uri, String name, String qName, Attributes atts) {
		if (name.equalsIgnoreCase("article")) {
			if (articles == null) {
				articles = new ArrayList<Article>();
			}
			// StringBuffer reset
			newDocumentType(name, atts);
		} else if (name.equalsIgnoreCase("book")) {
			newDocumentType(name, atts);
		} else if (name.equalsIgnoreCase("incollection")) {
			newDocumentType(name, atts);
		} else if (name.equalsIgnoreCase("inproceedings")) {
			newDocumentType(name, atts);
		} else if (name.equalsIgnoreCase("masterthesis")) {
			newDocumentType(name, atts);
		} else if (name.equalsIgnoreCase("phdthesis")) {
			newDocumentType(name, atts);
		} else if (name.equalsIgnoreCase("proceedings")) {
			newDocumentType(name, atts);
		} else if (name.equalsIgnoreCase("publication")) {
			newDocumentType(name, atts);
		} else if (name.equalsIgnoreCase("www")) {
			newDocumentType(name, atts);
		} else {
			document.append("<" + name + ">");
		}
	}

	private void newDocumentType(String name, Attributes atts) {
		document.setLength(0);
		document.append("<" + name);
		//Attributes
		for(int i =0;i<atts.getLength();i++){
			document.append(" " + atts.getLocalName(i) + "=\"" + atts.getValue(i) + "\"");
		}
		document.append(">");
	}
	
	@Override
	public void endElement(String uri, String localName, String qName)
			throws SAXException {
		document.append("</" + localName + ">");
		
		if(localName.equalsIgnoreCase("article")){
			writeToFile(new File(docTypes.get("article")));
		}else if(localName.equalsIgnoreCase("book")){
			writeToFile(new File(docTypes.get("book")));
		}else if(localName.equalsIgnoreCase("incollection")){
			writeToFile(new File(docTypes.get("incollection")));
		}else if(localName.equalsIgnoreCase("inproceedings")){
			writeToFile(new File(docTypes.get("inproceedings")));
		}else if(localName.equalsIgnoreCase("masterthesis")){
			writeToFile(new File(docTypes.get("masterthesis")));
		}else if(localName.equalsIgnoreCase("phdthesis")){
			writeToFile(new File(docTypes.get("phdthesis")));
		}else if(localName.equalsIgnoreCase("proceedings")){
			writeToFile(new File(docTypes.get("proceedings")));
		}else if(localName.equalsIgnoreCase("publication")){
			writeToFile(new File(docTypes.get("publication")));
		}else if(localName.equalsIgnoreCase("www")){
			writeToFile(new File(docTypes.get("www")));
		}
	}

	private void writeToFile(File file) {
		document.append("\n");
		try {
			output = new FileOutputStream(file, true);
			output.write(document.toString().getBytes());
			output.close();
			document.setLength(0);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void characters(char[] ch, int start, int length) throws SAXException {
		document.append(ch, start, length);
	}
	
}
