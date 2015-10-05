//
//  ARTAuthOptions.m
//  ably-ios
//
//  Created by Ricardo Pereira on 05/10/2015.
//  Copyright (c) 2015 Ably. All rights reserved.
//

#import "ARTAuthOptions.h"

#import "ARTAuthTokenDetails.h"

//X7: NSArray<NSString *>
static NSArray *decomposeKey(NSString *key) {
    return [key componentsSeparatedByString:@":"];
}

@implementation ARTAuthOptions

NSString *const ARTAuthOptionsMethodDefault = @"GET";

- (instancetype)init {
    self = [super init];
    if (self) {
        return [self initDefaults];
    }
    return self;
}

- (instancetype)initWithKey:(NSString *)key {
    self = [super init];
    if (self) {
        if (key != nil && decomposeKey(key).count != 2) {
            [NSException raise:@"Invalid key" format:@"%@ should be of the form <keyName>:<keySecret>", key];
        }
        else if (key != nil) {
            _key = [key copy];            
        }
        return [self initDefaults];
    }
    return self;
}

- (instancetype)initDefaults {
    _authMethod = ARTAuthOptionsMethodDefault;
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    ARTAuthOptions *options = [[[self class] allocWithZone:zone] init];
    
    options.key = self.key;
    options.token = self.token;
    options.useTokenAuth = self.useTokenAuth;
    options.authCallback = self.authCallback;
    options.authUrl = self.authUrl;
    options.authMethod = self.authMethod;
    options.authHeaders = self.authHeaders;
    options.authParams = self.authParams;
    options.queryTime = self.queryTime;
    
    return options;
}

- (NSString *)description {
    return [NSString stringWithFormat: @"ARTAuthOptions: key=%@ token=%@ authUrl=%@ authMethod=%@ hasAuthCallback=%d",
            self.key, self.token, self.authUrl, self.authMethod, self.authCallback != nil];
}

- (NSString *)token {
    return self.tokenDetails.token;
}

- (void)setToken:(NSString *)token {
    self.tokenDetails = [[ARTAuthTokenDetails alloc] initWithToken:token];
}

- (void)setAuthMethod:(NSString *)authMethod {
    if (authMethod == nil || authMethod.length == 0) {
        authMethod = ARTAuthOptionsMethodDefault;
    }
    
    _authMethod = [authMethod copy];
}

- (ARTAuthOptions *)mergeWith:(ARTAuthOptions *)precedenceOptions {
    ARTAuthOptions *merged = [self copy];
    
    if (precedenceOptions.key)
        merged.key = precedenceOptions.key;
    if (precedenceOptions.authCallback)
        merged.authCallback = precedenceOptions.authCallback;
    if (precedenceOptions.authUrl)
        merged.authUrl = precedenceOptions.authUrl;
    if (precedenceOptions.authMethod)
        merged.authMethod = precedenceOptions.authMethod;
    if (precedenceOptions.authHeaders)
        merged.authHeaders = precedenceOptions.authHeaders;
    if (precedenceOptions.authParams)
        merged.authParams = precedenceOptions.authParams;
    if (precedenceOptions.queryTime)
        merged.queryTime = precedenceOptions.queryTime;
    
    return merged;
}

- (BOOL)isMethodPOST {
    return [_authMethod isEqualToString:@"POST"];
}

- (BOOL)isMethodGET {
    return [_authMethod isEqualToString:@"GET"];
}

@end
