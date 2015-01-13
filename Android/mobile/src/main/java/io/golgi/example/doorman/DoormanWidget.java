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

import android.app.PendingIntent;
import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.Context;
import android.content.Intent;
import android.widget.RemoteViews;
import android.widget.Toast;

/**
 * Created by ianh on 5/1/14.
 */
public class DoormanWidget extends AppWidgetProvider {
    final String WIDGET_PUSHED = "io.golgi.example.doorman.WIDGET_PUSHED";

    @Override
    public void onUpdate(Context context,
                         AppWidgetManager appWidgetManager,
                         int[] appWidgetIds){
        for(int i=0; i<appWidgetIds.length; i++){

            int currentWidgetId = appWidgetIds[i];
            Intent intent = new Intent(Intent.ACTION_VIEW);
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            PendingIntent pending = PendingIntent.getActivity(context,0,intent, 0);
            RemoteViews views = new RemoteViews(context.getPackageName(),R.layout.widget_layout);
            views.setOnClickPendingIntent(R.id.button1, pending);

            intent = new Intent(WIDGET_PUSHED);
            PendingIntent pendingIntent = PendingIntent.getBroadcast(context, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT);
            views.setOnClickPendingIntent(R.id.widget_button, pendingIntent);
            appWidgetManager.updateAppWidget(currentWidgetId,views);

            if(!DoormanService.isStarted()){
                Intent serviceIntent = new Intent();
                serviceIntent.setClassName("io.golgi.example.doorman",
                        "io.golgi.example.doorman.DoormanService");
                context.startService(serviceIntent);
            }
        }
    }

    @Override
    public void onReceive(Context context, Intent intent)
    {
        // super
        super.onReceive(context, intent);

        //RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.widget_layout);
        // find your TextView here by id here and update it.
        if(WIDGET_PUSHED.equals(intent.getAction())){
            if(DoormanService.getInstance() != null && DoormanService.getInstance().isStarted()){
                DoormanService.getInstance().sendAccessRequest();
            }
            else{
                Toast.makeText(context,"Doorman Service is not started",Toast.LENGTH_SHORT).show();
                Intent i = new Intent(context,Doorman.class);
                i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                context.startActivity(i);
            }
        }
    }
}
