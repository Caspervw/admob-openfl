#import <Foundation/Foundation.h>

@interface AdManager : NSObject

- (void)refreshInterstitial;
- (void)initInterstitial:(NSString *)eventId testMode:(bool)testMode initCooldown:(int)initCooldown;
- (void)showInterstitial;

@end
