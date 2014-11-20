#include <AD.h>
#import <UIKit/UIKit.h>
#import <GADBannerView.h>
#import <GADInterstitial.h>
#import <GADInterstitialDelegate.h>
#import "include/AdManager.h"

namespace admobIOS {

    static GADBannerView *bannerView_;
	static UIViewController *rootView;
    static bool testAds;
    static bool adViewRendered = false;

    static GADInterstitial *interstitial_;
    static bool testInterstitial;

    static const char *interstitialId;   
    static double interstitialTime = -1.0;
    static bool startViewingIntersitials = false;

    static AdManager * adManager;

	void initAd(const char *ID, int x, int y, int size, bool testMode) {
		testAds = testMode;
		rootView = [[[UIApplication sharedApplication] keyWindow] rootViewController];

		NSString *GADID = [[NSString alloc] initWithUTF8String: ID];

		if (size == 0) {
			bannerView_ = [[GADBannerView alloc] initWithAdSize : kGADAdSizeSmartBannerPortrait];
		}
		else if (size == 1) {
			bannerView_ = [[GADBannerView alloc] initWithAdSize : kGADAdSizeSmartBannerLandscape];
		}

		int xPos = 0;
		int yPos = 0;

		if (x == 1) {
			xPos = rootView.view.frame.size.width - bannerView_.bounds.size.width;
		}
		else if (x == 2) {
			xPos = (rootView.view.frame.size.width - bannerView_.bounds.size.width) / 2;
		}

		if (y == 1) {
			yPos = rootView.view.frame.size.height - bannerView_.bounds.size.height;
		}
		else if (y == 2) {
			yPos = (rootView.view.frame.size.height - bannerView_.bounds.size.height) / 2;
		}

		[bannerView_ setFrame: CGRectMake(
			xPos,
			yPos,
			bannerView_.bounds.size.width,
			bannerView_.bounds.size.height
		)];

		bannerView_.adUnitID = GADID;
		bannerView_.rootViewController = rootView;

		refreshAd();
	}

    void showAd() {
    	if(!adViewRendered) {
			[rootView.view addSubview: bannerView_];
			adViewRendered = true;
		}

		bannerView_.hidden = NO;
    }

    void hideAd() {
    	bannerView_.hidden = YES;		
    }

	void refreshAd() {
		GADRequest *request = [[GADRequest alloc] init];
		[bannerView_ loadRequest:request];
	}

	void initInterstitial(const char *Id, bool testMode, int initCooldown) {
		if(adManager == nil) {
			adManager = [[AdManager alloc] init];
		}

		NSString *nsInterstitialId = [[NSString alloc] initWithUTF8String: Id];

		[adManager initInterstitial:nsInterstitialId testMode:testMode initCooldown:initCooldown];      
	}

	void refreshInterstitial() {
		[adManager refreshInterstitial];
	}

    void showInterstitial() {
    	[adManager showInterstitial];
    }
}