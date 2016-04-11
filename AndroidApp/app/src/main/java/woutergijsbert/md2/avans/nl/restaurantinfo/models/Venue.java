package woutergijsbert.md2.avans.nl.restaurantinfo.models;

public class Venue {

    public int id;
    public String name;
    public String category;
    public String telephone;
    public String tagline;
    public String website_url;
    public Address address;
    public Geolocation geolocation;

    public String getInfo(){
        String content = "Category: "+category+"\n";
        content += "Tagline: "+tagline+"\n\n";

        content += "Website: "+website_url+"\n";
        content += "Telephone: "+telephone+"\n";
        return  content;
    }

}
