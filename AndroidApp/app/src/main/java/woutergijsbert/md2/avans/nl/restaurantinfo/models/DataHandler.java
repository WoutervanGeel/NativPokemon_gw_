package woutergijsbert.md2.avans.nl.restaurantinfo.models;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import java.util.ArrayList;
import java.util.List;


public class DataHandler {

    private static List<Venue> venues;

    public static List<Venue> getVenues() {
        return venues;
    }

    public static List<Venue> parseJson(String json){
        List<Venue> venues = new ArrayList<>();

        JSONObject jsonObject=null;
        try {
            jsonObject = new JSONObject(json);
            JSONArray items = jsonObject.getJSONArray("results");

            for(int i=0;i<items.length();i++){
                JSONObject jObject = items.getJSONObject(i);

                Venue venue = new Venue();
                venue.id = jObject.getInt("id");
                venue.name = jObject.getString("name");
                venue.category = jObject.getString("category");
                venue.telephone = jObject.getString("telephone");
                venue.website_url = jObject.getString("website_url");
                venue.tagline = jObject.getString("tagline");

                JSONObject jAddress = jObject.getJSONObject("address");
                venue.address = new Address(jAddress.getString("street"),
                        jAddress.getString("zipcode"),
                        jAddress.getString("city"),
                        jAddress.getString("region"),
                        jAddress.getString("country"));

                JSONObject jGeo = jObject.getJSONObject("geolocation");
                venue.geolocation = new Geolocation(jGeo.getDouble("latitude"),
                        jGeo.getDouble("longitude"));

                venues.add(venue);
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }

        return venues;
    }
}
