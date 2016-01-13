
#import <Foundation/Foundation.h>

@interface ISCache : NSObject

+ (void) removeCache;
+ (void) setObject:(NSData*)data forKey:(NSString*)key;
+ (id) objectForKey:(NSString*)key;

@end
