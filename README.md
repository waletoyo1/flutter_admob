# flutter_admob
How to Integrate Admob into Flutter Apps
* This tutorial covers integrating banner, interstitial and rewarded video admob ads in flutter apps.
* This tutorial assume you already have an admob account, app Id and various ad units.


## Initial Step
* Add the firebase_admob package in your pubspec.yaml file
* Add this under the application tag of your manifest.xml file :
    <meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="[ADMOB_APP_ID]"/>

