//
//  BIMailToURIParser.m
//  BIMailToURIParser
//
//  Created by Bryan Irace on 3/13/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

#import "BIMailToURIParser.h"

@interface BIMailToURIParser()

@property (nonatomic, copy) NSArray *toRecipients;
@property (nonatomic, copy) NSArray *ccRecipients;
@property (nonatomic, copy) NSArray *bccRecipients;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *body;

@end

@implementation BIMailToURIParser

+ (BOOL)isMailToURL:(NSURL *)URL {
    return [[URL scheme] isEqualToString:@"mailto"];
}

- (id)initWithURL:(NSURL *)URL {
    if (self = [super init]) {
        if ([[self class] isMailToURL:URL]) {
            NSArray *components = split([URL absoluteString], @":");
            
            NSString *path = [components lastObject];
            
            NSArray *secondaryComponents = split(path, @"?");
            
            NSString *recipientString = secondaryComponents[0];
            
            self.toRecipients = split(recipientString, @",");
            
            if ([secondaryComponents count] == 2) {
                NSDictionary *queryParameters = queryStringToDictionary([secondaryComponents lastObject]);
                
                self.ccRecipients = split(queryParameters[@"cc"], @",");
                self.bccRecipients = split(queryParameters[@"bcc"], @",");
                self.subject = queryParameters[@"subject"];
                self.body = queryParameters[@"body"];
            }
        }
    }
    
    return self;
}

#pragma mark - Private

static inline NSDictionary *queryStringToDictionary(NSString *string) {
    NSMutableDictionary *parameterDictionary = [NSMutableDictionary dictionary];
    
    NSArray *parameterStrings = split(string, @"&");
    
    for (NSString *parameterString in parameterStrings) {
        NSArray *parameterComponents = split(parameterString, @"=");
        
        if ([parameterComponents count] == 2)
            parameterDictionary[URLDecode(parameterComponents[0])] = URLDecode(parameterComponents[1]);
    }
    
    return parameterDictionary;
}

static inline NSArray *split(NSString *string, NSString *delimeter) {
    return [string componentsSeparatedByString:delimeter];
}

static inline NSString *URLDecode(NSString *string) {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(NULL, (CFStringRef)string,
                                                                                    CFSTR("")));
}

@end
