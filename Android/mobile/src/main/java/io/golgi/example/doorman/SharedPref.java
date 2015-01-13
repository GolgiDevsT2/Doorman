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

import android.content.Context;
import android.content.SharedPreferences;

/**
 * Created by ianh on 4/25/14.
 */
public class SharedPref {
    private Context context;

    public SharedPref(Context context){
        this.context = context;
    }

    private SharedPreferences getSP(){
        SharedPreferences settings = context.getSharedPreferences("doorman", 0);
        return settings;
    }
    private SharedPreferences.Editor getSPEditor(){
        SharedPreferences.Editor editor = getSP().edit();
        return editor;
    }

    public void writeKey(String key){
        SharedPreferences.Editor editor = getSPEditor();
        editor.putString("key",key);
        editor.commit();
    }
//    public void setKey(String val){
//        if(key.length() == 0){
//            writeKey(val);
//        }
//        key = val;
//    }
//    public void setPin(String val){
//        pin = val;
//    }

    public void writeUName(String uName){
        SharedPreferences.Editor editor = getSPEditor();
        editor.putString("uName",uName);
        editor.commit();
    }
    //    public void setUsername(String val){
//        if(username.length() == 0){
//            writeUName(val);
//        }
//        username = val;
//    }
//    public void setKeyGranter(String val){
//        key_granter = val;
//    }
    public void setInFlight(boolean val){
        SharedPreferences.Editor editor = getSPEditor();
        editor.putBoolean("inFlight", val);
        editor.commit();
    }

    public String readKey(){
        return getSP().getString("key", "");
    }
    //    public String getKey(){
//        return key;
//    }
    public String readUName(){
        return getSP().getString("uName", "");
    }

    //    public String getPin(){
//        return pin;
//    }
//    public String getKeyGranter(){
//        return key_granter;
//    }
    public boolean getInFlight(){
        return getSP().getBoolean("inFlight", false);
    }
}
