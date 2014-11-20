#import "include/AdManager.h"
#import <GADBannerView.h>
#import <GADInterstitial.h>
#import <GADInterstitialDelegate.h>

@interface AdManager ()<GADInterstitialDelegate>
	@property (strong, nonatomic) NSString * _GADID;
	@property (strong, nonatomic) GADInterstitial * _interstitial;
	@property (strong, nonatomic) UIViewController * rootView;	

	@property (assign) BOOL backgroundMusicPlaying;
	@property (assign) BOOL adReady;
	@property (assign) double interstitialTime;

@end

@implementation AdManager

#pragma mark - Public

- (void)dealloc {
	// [self.audioController release];
	[super dealloc];
}


- (void)refreshInterstitial {	
    self._interstitial = [[GADInterstitial alloc] init];
    // self._interstitial.delegate = this;
    self._interstitial.adUnitID = self._GADID;

	GADRequest *request = [[GADRequest alloc] init];
    [self._interstitial loadRequest:[GADRequest request]];
    
	self._interstitial.delegate = self;
    NSLog(@"refreshInterstitial");
}

- (void)initInterstitial:(NSString *)interstitialId testMode:(bool)testMode initCooldown:(int)initCooldown {
	self.adReady          = false;
	self._GADID           = interstitialId;
	self.rootView         = [[[UIApplication sharedApplication] keyWindow] rootViewController];
	self.interstitialTime = CACurrentMediaTime() + initCooldown;
}

- (void)showInterstitial {
	//Check if the interstitial is ready
	if(self.adReady) {
		self.rootView = [[[UIApplication sharedApplication] keyWindow] rootViewController];
	    [self._interstitial presentFromRootViewController:self.rootView]; 
	    self.adReady = false;
	}
	else if(CACurrentMediaTime() > self.interstitialTime) {			
		[self refreshInterstitial]; //110 sec cooldown		
	}
}

// Called before the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {  
	//Reset timers
    self.interstitialTime = CACurrentMediaTime() + 110;
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
	self.adReady = true;
}

/// Called when an interstitial ad request failed.
- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {}

/// Called just before presenting an interstitial.
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {}

/// Called just after dismissing an interstitial and it has animated off the screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {}

/// Called just before the application will background or terminate because the user clicked on an
/// ad that will launch another application (such as the App Store).
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {}

@end