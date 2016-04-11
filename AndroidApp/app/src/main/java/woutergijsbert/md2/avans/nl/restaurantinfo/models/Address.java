package woutergijsbert.md2.avans.nl.restaurantinfo.models;

public class Address {

    public String street;
    public String zipcode;
    public String city;
    public String region;
    public String country;

    public Address(String street, String zipcode, String city, String region, String country) {
        this.street = street;
        this.zipcode = zipcode;
        this.city = city;
        this.region = region;
        this.country = country;
    }
}
