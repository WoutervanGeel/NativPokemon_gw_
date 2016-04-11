package woutergijsbert.md2.avans.nl.restaurantinfo;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import woutergijsbert.md2.avans.nl.restaurantinfo.models.DataHandler;
import woutergijsbert.md2.avans.nl.restaurantinfo.models.Venue;
import java.util.ArrayList;
import java.util.List;

public class VenueListActivity extends AppCompatActivity {

    private boolean mTwoPane;
    private SimpleItemRecyclerViewAdapter adapter;
    private View recyclerView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_venue_list);

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        toolbar.setTitle(getTitle());

        recyclerView = findViewById(R.id.venue_list);
        adapter = new SimpleItemRecyclerViewAdapter();

        // The detail container view will be present only in the large-screen layouts (res/values-w900dp).
        // If this view is present, then the activity should be in two-pane mode.
        if (findViewById(R.id.venue_detail_container) != null) {
            mTwoPane = true;
        }


        String url = "https://api.eet.nu/venues?query=den-bosch";
        StringRequest jReq = new StringRequest(url,
                new Response.Listener<String>() {

                    @Override
                    public void onResponse(String response) {
                        adapter.update(DataHandler.parseJson(response));
                        ((RecyclerView) recyclerView).setAdapter(adapter);
                    }
                }, new Response.ErrorListener() {

            @Override
            public void onErrorResponse(VolleyError error) {
                Toast.makeText(VenueListActivity.this, "Couldn't load data", Toast.LENGTH_LONG).show();
            }
        });

        // process data
        RequestQueue mRequestQueue = Volley.newRequestQueue(getApplicationContext());
        mRequestQueue.add(jReq);

        // loading dialog
        /*
        progressDialog = new ProgressDialog(this);
        progressDialog.setMessage("Loading...");
        progressDialog.show();*/
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.main, menu);
        return true;
    }

    public class SimpleItemRecyclerViewAdapter extends RecyclerView.Adapter<SimpleItemRecyclerViewAdapter.ViewHolder> {

        private List<Venue> mValues;

        public SimpleItemRecyclerViewAdapter() {
            mValues = new ArrayList<>();
        }

        public void update(List<Venue> items) {
            mValues = items;

            notifyDataSetChanged();
        }

        @Override
        public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(parent.getContext())
                    .inflate(R.layout.venue_list_content, parent, false);
            return new ViewHolder(view);
        }

        @Override
        public void onBindViewHolder(final ViewHolder holder, int position) {
            holder.mItem = mValues.get(position);
            holder.mContentView.setText(mValues.get(position).name);

            holder.mView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    if (mTwoPane) {
                        Bundle arguments = new Bundle();
                        arguments.putString("title", holder.mItem.name);
                        arguments.putString("content", holder.mItem.getInfo());
                        arguments.putString("telephone", holder.mItem.telephone.toString());
                        VenueDetailFragment fragment = new VenueDetailFragment();
                        fragment.setArguments(arguments);
                        getSupportFragmentManager().beginTransaction()
                                .replace(R.id.venue_detail_container, fragment)
                                .commit();
                    } else {
                        Context context = v.getContext();
                        Intent intent = new Intent(context, VenueDetailActivity.class);
                        intent.putExtra("title", holder.mItem.name);
                        intent.putExtra("content", holder.mItem.getInfo());
                        intent.putExtra("telephone", holder.mItem.telephone);
                        context.startActivity(intent);
                    }
                }
            });
        }

        @Override
        public int getItemCount() {
            return mValues.size();
        }

        public class ViewHolder extends RecyclerView.ViewHolder {
            public final View mView;
            public final TextView mContentView;
            public Venue mItem;

            public ViewHolder(View view) {
                super(view);
                mView = view;
                mContentView = (TextView) view.findViewById(R.id.content);
            }

            @Override
            public String toString() {
                return super.toString() + " '" + mContentView.getText() + "'";
            }
        }

    }
}
