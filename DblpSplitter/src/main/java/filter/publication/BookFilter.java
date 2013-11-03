package filter.publication;

/**
 * @author Michael Weichselbaumer
 *
 */
public class BookFilter extends PublicationFilter {

	@Override
	public String getPublicationTag() {
		return "book";
	}
}
