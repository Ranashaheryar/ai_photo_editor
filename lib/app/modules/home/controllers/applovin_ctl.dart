
import 'dart:math';

import 'package:applovin_max/applovin_max.dart';
import 'package:get/get.dart';
import 'package:image_editor/app/utils/app_strings.dart';

enum AdLoadState { notLoaded, loading, loaded }

class AppLovin_CTL extends GetxController {
  //TODO: Implement HomeController

   final String _sdk_key =AppStrings.MAX_SDK;

  final String _interstitial_ad_unit_id = AppStrings.MAX_INTER_ID;
  // final String _rewarded_ad_unit_id = "ANDROID_REWARDED_AD_UNIT_ID";
  final String _banner_ad_unit_id = AppStrings.MAX_BANNER_ID;
  final String _mrec_ad_unit_id = AppStrings.MAX_MREC_ID;

  // Create states
var isInitialized = false;
var interstitialLoadState = AdLoadState.notLoaded;
var interstitialRetryAttempt = 0;
var rewardedAdLoadState = AdLoadState.notLoaded;
var rewardedAdRetryAttempt = 0;
var isProgrammaticBannerCreated = false;
var isProgrammaticBannerShowing = false;
var isWidgetBannerShowing = false;
var isProgrammaticMRecCreated = false;
var isProgrammaticMRecShowing = false;
var isWidgetMRecShowing = false;
  

  @override
  void onInit() {
    super.onInit();
    initializePlugin();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

 

Future<void> initializePlugin() async {
    print("Initializing SDK...");

    Map? configuration = await AppLovinMAX.initialize(_sdk_key);
    if (configuration != null) {
      isInitialized = true;

      print("SDK Initialized: $configuration");

      attachAdListeners();
       AppLovinMAX.loadInterstitial(_interstitial_ad_unit_id);
      //  AppLovinMAX.createMRec(AppStrings.MAX_MREC_ID, AdViewPosition.centered);
    }
  }


   void attachAdListeners() {
    /// Interstitial Ad Listeners
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        interstitialLoadState = AdLoadState.loaded;

        // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialAdReady(_interstitial_ad_unit_id) will now return 'true'
        print('Interstitial ad loaded from ' + ad.networkName);

        // Reset retry attempt
        interstitialRetryAttempt = 0;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        interstitialLoadState = AdLoadState.notLoaded;

        // Interstitial ad failed to load
        // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
        interstitialRetryAttempt = interstitialRetryAttempt + 1;

        int retryDelay = pow(2, min(6, interstitialRetryAttempt)).toInt();
        print('Interstitial ad failed to load with code ' + error.code.toString() + ' - retrying in ' + retryDelay.toString() + 's');

        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
          AppLovinMAX.loadInterstitial(_interstitial_ad_unit_id);
        });
      },
      onAdDisplayedCallback: (ad) {
        print('Interstitial ad displayed');
      },
      onAdDisplayFailedCallback: (ad, error) {
        interstitialLoadState = AdLoadState.notLoaded;
        print('Interstitial ad failed to display with code ' + error.code.toString() + ' and message ' + error.message);
      },
      onAdClickedCallback: (ad) {
        print('Interstitial ad clicked');
      },
      onAdHiddenCallback: (ad) {
        interstitialLoadState = AdLoadState.notLoaded;
        print('Interstitial ad hidden');
      },
    ));


    /// Banner Ad Listeners
    AppLovinMAX.setBannerListener(AdViewAdListener(onAdLoadedCallback: (ad) {
      print('Banner ad loaded from ' + ad.networkName);
    }, onAdLoadFailedCallback: (adUnitId, error) {
      print('Banner ad failed to load with error code ' + error.code.toString() + ' and message: ' + error.message);
    }, onAdClickedCallback: (ad) {
      print('Banner ad clicked');
    }, onAdExpandedCallback: (ad) {
      print('Banner ad expanded');
    }, onAdCollapsedCallback: (ad) {
      print('Banner ad collapsed');
    }));

    /// MREC Ad Listeners
    AppLovinMAX.setMRecListener(AdViewAdListener(onAdLoadedCallback: (ad) {
      print('MREC ad loaded from ' + ad.networkName);
    }, onAdLoadFailedCallback: (adUnitId, error) {
      print('MREC ad failed to load with error code ' + error.code.toString() + ' and message: ' + error.message);
    }, onAdClickedCallback: (ad) {
      print('MREC ad clicked');
    }, onAdExpandedCallback: (ad) {
      print('MREC ad expanded');
    }, onAdCollapsedCallback: (ad) {
      print('MREC ad collapsed');
    }));

}



  void showInterstitial() async{
    
   bool? isAdReady= await AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id);
    if (isInitialized && isAdReady!) {
      AppLovinMAX.showInterstitial(_interstitial_ad_unit_id);
    }
  }



}
