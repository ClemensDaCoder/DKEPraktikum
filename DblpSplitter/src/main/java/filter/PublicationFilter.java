package filter;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.XMLFilterImpl;

public abstract class PublicationFilter extends XMLFilterImpl {
	
	private boolean workingOnArticle = false;
	private final static String ROOT_ELEMENT = "dblp";

	/** Checks if element is {@code publicationTag} element and filters out any other element
	 * <p>
	 * @see org.xml.sax.helpers.XMLFilterImpl#startElement(java.lang.String, java.lang.String, java.lang.String, org.xml.sax.Attributes)
	 */
	@Override
	public void startElement(String uri, String localName, String qName,
			Attributes atts) throws SAXException {
		if (workingOnArticle || getPublicationTag().equalsIgnoreCase(localName)) {
			super.startElement(uri, localName, qName, atts);
			workingOnArticle = true;
		} else if (ROOT_ELEMENT.equalsIgnoreCase(localName)) {
			super.startElement(uri, localName, qName, atts);
		}
	}

	/** Checks if ending element is {@code publicationTag} element and filters out any other element.
	 * 
	 * @see org.xml.sax.helpers.XMLFilterImpl#endElement(java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	public void endElement(String uri, String localName, String qName)
			throws SAXException {
		if (workingOnArticle || ROOT_ELEMENT.equalsIgnoreCase(localName)) {			
			super.endElement(uri, localName, qName);
			if (getPublicationTag().equalsIgnoreCase(localName)) {
				workingOnArticle = false;
			}
		}
	}
	
	/** If character sequence belongs to {@code pages} element, page information is extracted
	 *  in order to be put in replacement elements {@code from} and {@code to}.
	 * <p>
	 * @see org.xml.sax.helpers.XMLFilterImpl#characters(char[], int, int)
	 */
	@Override
	public void characters(char[] ch, int start, int length) throws SAXException {
		if (workingOnArticle) {
			super.characters(ch, start, length);
		} 
	}
	
	public abstract String getPublicationTag();

}
