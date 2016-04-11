package woutergijsbert.md2.avans.nl.restaurantinfo;

import android.app.Activity;
import android.support.design.widget.CollapsingToolbarLayout;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import woutergijsbert.md2.avans.nl.restaurantinfo.dummy.DummyContent;
import woutergijsbert.md2.avans.nl.restaurantinfo.models.DataHandler;
import woutergijsbert.md2.avans.nl.restaurantinfo.models.Venue;

/**
 * A fragment representing a single Venue detail screen.
 * This fragment is either contained in a {@link VenueListActivity}
 * in two-pane mode (on tablets) or a {@link VenueDetailActivity}
 * on handsets.
 */
public class VenueDetailFragment extends Fragment {

    /**
     * Mandatory empty constructor for the fragment manager to instantiate the
     * fragment (e.g. upon screen orientation changes).
     */
    public VenueDetailFragment() {
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Activity activity = this.getActivity();
        CollapsingToolbarLayout appBarLayout = (CollapsingToolbarLayout) activity.findViewById(R.id.toolbar_layout);
        if (appBarLayout != null) {
            appBarLayout.setTitle(getArguments().getString("title"));
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.venue_detail, container, false);

        ((TextView) rootView.findViewById(R.id.venue_detail)).setText(getArguments().getString("content"));

        return rootView;
    }
}
