package splitter;

import org.xml.sax.SAXException;
import org.xml.sax.ext.LexicalHandler;

public class UmlautHandler implements LexicalHandler {

	@Override
	public void startDTD(String name, String publicId, String systemId)
			throws SAXException {
		System.out.println("STARRT DTD");
		
	}

	@Override
	public void endDTD() throws SAXException {
		System.out.println("END DTD");
		
	}

	@Override
	public void startEntity(String name) throws SAXException {
		System.out.println("START - Name of entity: " + name);
		
	}

	@Override
	public void endEntity(String name) throws SAXException {
		System.out.println("END - Name of entity: " + name);
		
	}

	@Override
	public void startCDATA() throws SAXException {
		System.out.println("START CDATA");
		
	}

	@Override
	public void endCDATA() throws SAXException {
		System.out.println("END CDATA ");
		
	}

	@Override
	public void comment(char[] ch, int start, int length) throws SAXException {
		System.out.println("Comment: " + String.valueOf(ch, start, length));
		
	}

}
