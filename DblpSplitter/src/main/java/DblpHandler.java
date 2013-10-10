import org.xml.sax.Attributes;
import org.xml.sax.ext.DefaultHandler2;


public class DblpHandler extends DefaultHandler2 {
	
	
	/* (non-Javadoc)
	 * @see org.xml.sax.helpers.DefaultHandler#startDocument()
	 */
	@Override
	public void startDocument()  {
		
	}
	
	/* (non-Javadoc)
	 * @see org.xml.sax.helpers.DefaultHandler#endDocument()
	 */
	@Override
	public void endDocument() {
		
	}
	
	/**
	 * {@inheritDoc}
	 * <p>In case of an element interesting for us .. we do something
	 */
	@Override
	public void startElement(String uri,
			String name,
			String qName,
			Attributes atts) {
		
	}
}
