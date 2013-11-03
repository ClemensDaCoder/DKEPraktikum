package filter.publication;

/**
 * @author Michael Weichselbaumer
 *
 */
public class InProceedingsFilter extends PublicationFilter {

	@Override
	public String getPublicationTag() {
		return "inproceedings";
	}

}
