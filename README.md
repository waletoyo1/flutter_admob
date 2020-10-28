# flutter_admob
How to Integrate Admob into Flutter Apps
* This tutorial covers integrating banner, interstitial and rewarded video admob ads in flutter apps.
* This tutorial assume you already have an admob account, app Id and various ad units.


## Initial Steps
* Add the firebase_admob package in your pubspec.yaml file
* Add this under the application tag of your manifest.xml file : <p>
\<meta-data android:name="com.google.android.gms.ads.APPLICATION_ID" android:value="[ADMOB_APP_ID]"/> 
 
*  Change the [ADMOB_APP_ID] to your admob app Id.
*  Import the admob package in your desired file
*  See the main.dart file of this project for details.

NB: For interstitial and rewarded video ads, the load function must be called before the show function is called.




