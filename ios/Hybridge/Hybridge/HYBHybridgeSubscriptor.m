/**
 * Hybridge
 * (c) Telefonica Digital, 2013 - All rights reserved
 * License: GNU Affero V3 (see LICENSE file)
 */

#import "HYBHybridgeSubscriptor.h"
#import "HYBHybridge.h"

@interface HYBHybridgeSubscriptor()

@property (strong, nonatomic) NSMutableDictionary *subscriptions;

@end

@implementation HYBHybridgeSubscriptor

static HYBHybridgeSubscriptor *sharedInstance = nil;

+ (HYBHybridgeSubscriptor *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        // Initialization here
    }
    
    return self;
}

- (NSMutableDictionary *)subscriptions {
    
    if (!_subscriptions) {
        _subscriptions = [[NSMutableDictionary alloc] init];
    }
    
    return _subscriptions;
}

- (void)subscribeAction:(NSString *)action withHandler:(HybridgeHandlerBlock_t)handlerBlock {
    
    @try {
        [self.subscriptions setObject:handlerBlock forKey:action];
    }
    @catch (NSException * e) {
    }
}

- (void)unsubscribeAction:(NSString *)action {
    
    @try {
        [self.subscriptions removeObjectForKey:action];
    }
    @catch (NSException * e) {
    }
}

- (BOOL)isSubscribedForAction:(NSString *)action {
    
    return ([self.subscriptions objectForKey:action] != nil);
}

- (HybridgeHandlerBlock_t)handlerForAction:(NSString *)action {
    
    return [self.subscriptions objectForKey:action];
}

@end
