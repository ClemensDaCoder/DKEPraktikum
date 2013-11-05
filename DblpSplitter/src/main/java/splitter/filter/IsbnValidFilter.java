package splitter.filter;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.XMLFilterImpl;

public class IsbnValidFilter extends XMLFilterImpl {
	
	private boolean workingOnIsbnElement = false;
	
	private static final String ISBN_TAG = "isbn";
	private static final Pattern ISBNPATTERN = Pattern.compile("[\\d]*(-?[\\d]*)*X?");
	
	
	/** Checks if element is {@code isbn} element.
	 * <p>
	 * @see org.xml.sax.helpers.XMLFilterImpl#startElement(java.lang.String, java.lang.String, java.lang.String, org.xml.sax.Attributes)
	 */
	@Override
	public void startElement(String uri, String localName, String qName,
			Attributes atts) throws SAXException {
		if (ISBN_TAG.equalsIgnoreCase(localName)) {
			workingOnIsbnElement = true;
		}
		super.startElement(uri, localName, qName, atts);
	}

	/** Checks if ending element is {@code isbn}. <p>
	 * 
	 * @see org.xml.sax.helpers.XMLFilterImpl#endElement(java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	public void endElement(String uri, String localName, String qName)
			throws SAXException {
		if (ISBN_TAG.equalsIgnoreCase(localName)) {			
			workingOnIsbnElement = false;
		}
		super.endElement(uri, localName, qName);
	}
	
	/** If character sequence belongs to {@code isbn} element, isbn is validated against
	 * regular expression. <p> If pattern does not match, isbn is filtered out.
	 * @see org.xml.sax.helpers.XMLFilterImpl#characters(char[], int, int)
	 */
	@Override
	public void characters(char[] ch, int start, int length) throws SAXException {
		if (workingOnIsbnElement) {
			String isbn = String.valueOf(ch, start, length);
			Matcher matcher = ISBNPATTERN.matcher(isbn);
			if (matcher.matches()) {
				super.characters(ch, start, length);
			}
		} else {
			super.characters(ch, start, length);
		}
	}

}
