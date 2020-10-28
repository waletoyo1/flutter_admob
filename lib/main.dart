import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Admob App',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Admob App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //ad unit IDs
  String _bannerUnit = "";
  String _interstitialUnit = "";
  String _rewardedUnit = "";

  //defining  banner ad
   BannerAd _bannerAd;
   BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
   
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
   }
  //defining interstitial ad
   InterstitialAd _interstitialAd;
   InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }
  int _coins = 0;


  @override
  void initState() {
 
    super.initState();
    //load banner ad immediately the app loads
      _bannerAd ??= createBannerAd();
                      _bannerAd
                        ..load()
                        ..show();
    //initializing rewarded ad
     FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _bannerAd = createBannerAd()..load();
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("RewardedVideoAd event $event");
      if (event == RewardedVideoAdEvent.rewarded) {
        setState(() {
          _coins = _coins + 5;
        });
      }
    };
  }

  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
       
        title: Text(widget.title),
      ),
      body: Center(
   
        child: Column(
        
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text ("Coins: $_coins"),
         RaisedButton(onPressed: (){
           //load interstial ad
              _interstitialAd = createInterstitialAd()..load();
          //then show dialogbox
           
           showDialog(context: context, builder: (_)=>AlertDialog(
             title: Text('Show Interstitial Ad?'),
             actions: [
               FlatButton(onPressed: (){
              //show interstial ad
               _interstitialAd?.show().then((value){
                 //then pop the ad
                 Navigator.pop(context);
               });
               

               }, child: Text('Yes')),
                FlatButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('No'))
             ],
           ));


         }, child: Text('Load Interstitial Ad'),),

        RaisedButton(onPressed: (){
          //load rewarded ad
           RewardedVideoAd.instance.load(
                        adUnitId: RewardedVideoAd.testAdUnitId,
                        );

           showDialog(context: context, builder: (_)=>AlertDialog(
             title: Text('Show Rewarded Ad?'),
             actions: [
               FlatButton(onPressed: (){
                //show rewarded video
                RewardedVideoAd.instance.show().then((value){
                     //then pop the ad
                 Navigator.pop(context);
                });
               }, child: Text('Yes')),
                FlatButton(onPressed: (){
                    Navigator.pop(context);
                }, child: Text('No'))
             ],
           ));
        }, child: Text('Load Rewarded Ad'),),




         
          
          ],
        ),
      ),
     
    );
  }
}
