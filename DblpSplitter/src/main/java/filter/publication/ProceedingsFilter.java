package filter.publication;

/**
 * @author Michael Weichselbaumer
 *
 */
public class ProceedingsFilter extends PublicationFilter {

	@Override
	public String getPublicationTag() {
		return "proceedings";
	}

}
