//
//  ARTTypes.h
//  ably-ios
//
//  Created by Jason Choy on 08/12/2014.
//  Copyright (c) 2014 Ably. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompatibilityMacros.h"

@class ARTStatus;
@class ARTHttpResponse;
@class ARTMessage;
@class ARTPresenceMessage;
@class ARTAuthTokenParams;
@class ARTAuthTokenRequest;
@class ARTAuthTokenDetails;

typedef NS_ENUM(NSUInteger, ARTRealtimeConnectionState) {
    ARTRealtimeInitialized,
    ARTRealtimeConnecting,
    ARTRealtimeConnected,
    ARTRealtimeDisconnected,
    ARTRealtimeSuspended,
    ARTRealtimeClosing,
    ARTRealtimeClosed,
    ARTRealtimeFailed
};

typedef NS_ENUM(NSUInteger, ARTRealtimeChannelState) {
    ARTRealtimeChannelInitialised,
    ARTRealtimeChannelAttaching,
    ARTRealtimeChannelAttached,
    ARTRealtimeChannelDetaching,
    ARTRealtimeChannelDetached,
    ARTRealtimeChannelClosed,
    ARTRealtimeChannelFailed
};

ART_ASSUME_NONNULL_BEGIN

/// Decompose API key
__GENERIC(NSArray, NSString *) *decomposeKey(NSString *key);

// MARK: Callbacks definitions

typedef void (^ARTRealtimeChannelMessageCb)(ARTMessage *);

typedef void (^ARTRealtimeChannelStateCb)(ARTRealtimeChannelState, ARTStatus *);

typedef void (^ARTRealtimeConnectionStateCb)(ARTRealtimeConnectionState state);

typedef void (^ARTRealtimeChannelPresenceCb)(ARTPresenceMessage *);

typedef void (^ARTStatusCallback)(ARTStatus *status);

typedef void (^ARTHttpCb)(ARTHttpResponse *response);

typedef void (^ARTErrorCallback)(NSError *__art_nullable error);

// FIXME: review
typedef void (^ARTAuthCallback)(ARTAuthTokenParams *tokenParams, void(^callback)(ARTAuthTokenRequest *__art_nullable tokenRequest, NSError *__art_nullable error));

typedef void (^ARTTokenCallback)(ARTAuthTokenDetails *__art_nullable tokenDetails, NSError *__art_nullable error);

// FIXME: review
@protocol ARTCancellable
- (void)cancel;
@end

@protocol ARTSubscription
- (void)unsubscribe;
@end

// FIXME: review
@interface ARTIndirectCancellable : NSObject <ARTCancellable>

@property (readwrite, strong, nonatomic) id<ARTCancellable> cancellable;
@property (readonly, assign, nonatomic) BOOL isCancelled;

- (instancetype)init;
- (instancetype)initWithCancellable:(id<ARTCancellable>)cancellable;
- (void)cancel;

@end

ART_ASSUME_NONNULL_END
