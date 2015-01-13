package io.golgi.example.doorman;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.v4.app.DialogFragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.widget.DatePicker;
import android.widget.LinearLayout;

/**
 * Created by ianh on 4/24/14.
 */
public class CalendarDialogFragment extends DialogFragment {
    /* The activity that creates an instance of this dialog fragment must
    * implement this interface in order to receive event callbacks.
    * Each method passes the DialogFragment in case the host needs to query it. */
    public interface CalendarDialogListener {
        public void onCalendarDialogPositiveClick(int day, int month, int year);
    }

    // Use this instance of the interface to deliver action events
    CalendarDialogListener mListener;

    // Override the Fragment.onAttach() method to instantiate the NoticeDialogListener
    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);
        // Verify that the host activity implements the callback interface
        try {
            // Instantiate the NoticeDialogListener so we can send events to the host
            mListener = (CalendarDialogListener) activity;
        } catch (ClassCastException e) {
            // The activity doesn't implement the interface, throw exception
            throw new ClassCastException(activity.toString()
                    + " must implement NoticeDialogListener");
        }
    }

    public CalendarDialogFragment(){
        // empty constructor required
    }

    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {


        AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
        // Get the layout inflater
        LayoutInflater inflater = getActivity().getLayoutInflater();
        // Inflate and set the layout for the dialog
        // Pass null as the parent view because its going in the dialog layout
        final LinearLayout layout = (LinearLayout) inflater.inflate(R.layout.key_calendar, null);
        // get the text fields
        //final EditText pinText = (EditText) layout.findViewById(R.id.key_cal);
        final DatePicker datePicker = (DatePicker) layout.findViewById(R.id.datePicker);

        Log.i("OMN", "Creating dialog");
        builder.setView(layout)
                // Add action buttons
                .setPositiveButton(R.string.key_request_submit, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int id) {
                        mListener.onCalendarDialogPositiveClick(datePicker.getDayOfMonth(),datePicker.getMonth(),datePicker.getYear());
                    }
                })
                .setNegativeButton(R.string.key_request_cancel, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        CalendarDialogFragment.this.getDialog().cancel();
                    }
                });

        // build the dialog
        final AlertDialog dialog = builder.create();
        return dialog;
    }
}
