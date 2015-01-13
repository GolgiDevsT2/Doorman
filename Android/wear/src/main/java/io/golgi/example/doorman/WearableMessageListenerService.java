//
// This Software (the "Software") is supplied to you by Openmind Networks
// Limited ("Openmind") your use, installation, modification or
// redistribution of this Software constitutes acceptance of this disclaimer.
// If you do not agree with the terms of this disclaimer, please do not use,
// install, modify or redistribute this Software.
//
// TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED ON AN
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, EITHER
// EXPRESS OR IMPLIED INCLUDING, WITHOUT LIMITATION, ANY WARRANTIES OR
// CONDITIONS OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A
// PARTICULAR PURPOSE.
//
// Each user of the Software is solely responsible for determining the
// appropriateness of using and distributing the Software and assumes all
// risks associated with use of the Software, including but not limited to
// the risks and costs of Software errors, compliance with applicable laws,
// damage to or loss of data, programs or equipment, and unavailability or
// interruption of operations.
//
// TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW OPENMIND SHALL NOT
// HAVE ANY LIABILITY FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, WITHOUT LIMITATION,
// LOST PROFITS, LOSS OF BUSINESS, LOSS OF USE, OR LOSS OF DATA), HOWSOEVER
// CAUSED UNDER ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
// LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
// WAY OUT OF THE USE OR DISTRIBUTION OF THE SOFTWARE, EVEN IF ADVISED OF
// THE POSSIBILITY OF SUCH DAMAGES.
//

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
