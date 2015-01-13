package io.golgi.example.doorman;

import android.content.Intent;
import android.support.v4.content.LocalBroadcastManager;
import android.util.Log;

import com.google.android.gms.wearable.MessageEvent;
import com.google.android.gms.wearable.WearableListenerService;

public class WearableMessageListenerService extends WearableListenerService {

    public final static String ACCESS_INTENT = "io.golgi.example.doorman.wear.ACCESS_INTENT";
    public final static String ACCESS_RESULT = "io.golgi.example.doorman.wear.ACCESS_RESULT";
    public final static String ACCESS_SUCCESS = "io.golgi.example.doorman.WEARABLE_SUCCESS";
    public final static String ACCESS_FAILED = "io.golgi.example.doorman.WEARABLE_FAILURE";

    @Override
    public void onMessageReceived(MessageEvent event){
        LocalBroadcastManager localBroadcastManager = LocalBroadcastManager.getInstance(this);
        Intent intent = new Intent(ACCESS_INTENT);

        Log.i("OMN","Received message from phone");

        if(event.getPath().equals(ACCESS_SUCCESS)){
            intent.putExtra(ACCESS_RESULT, ACCESS_SUCCESS);
            Log.i("OMN","Message from phone was success");
        }
        else{
            intent.putExtra(ACCESS_RESULT,ACCESS_FAILED);
            Log.i("OMN","Message from phone was failure");
        }
        localBroadcastManager.sendBroadcast(intent);
    }
}
