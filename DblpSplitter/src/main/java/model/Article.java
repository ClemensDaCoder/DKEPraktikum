package model;

public class Article extends Publication {
	
	/* key CDATA #REQUIRED
     mdate CDATA #IMPLIED
     publtype CDATA #IMPLIED
     reviewid CDATA #IMPLIED
     rating CDATA #IMPLIED */
	
	private String key;
	private String mdate;
	private String publtype;
	private String reviewid;
	private String rating;
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getMdate() {
		return mdate;
	}
	public void setMdate(String mdate) {
		this.mdate = mdate;
	}
	public String getPubltype() {
		return publtype;
	}
	public void setPubltype(String publtype) {
		this.publtype = publtype;
	}
	public String getReviewid() {
		return reviewid;
	}
	public void setReviewid(String reviewid) {
		this.reviewid = reviewid;
	}
	public String getRating() {
		return rating;
	}
	public void setRating(String rating) {
		this.rating = rating;
	}
	
	

}
