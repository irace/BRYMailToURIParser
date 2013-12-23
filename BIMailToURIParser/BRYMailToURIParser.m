//
//  BRYMailToURIParser.m
//  BRYMailToURIParser
//
//  Created by Bryan Irace on 3/13/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

#import "BRYMailToURIParser.h"

static NSString * const MailToProtocol = @"mailto";
static NSString * const ParameterCC = @"cc";
static NSString * const ParameterBCC = @"bcc";
static NSString * const ParameterSubject = @"subject";
static NSString * const ParameterBody = @"body";

@interface BRYMailToURIParser()

@property (nonatomic, copy) NSArray *toRecipients;
@property (nonatomic, copy) NSArray *ccRecipients;
@property (nonatomic, copy) NSArray *bccRecipients;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *body;

@end

@implementation BRYMailToURIParser

+ (BOOL)isMailToURL:(NSURL *)URL {
    return [[URL scheme] isEqualToString:MailToProtocol];
}

- (id)initWithURL:(NSURL *)URL {
    if (self = [super init]) {
        if ([[self class] isMailToURL:URL]) {
            NSArray *components = [[URL absoluteString] componentsSeparatedByString:@":"];
            
            NSString *path = [components lastObject];
            
            NSArray *secondaryComponents = [path componentsSeparatedByString:@"?"];
            
            NSString *recipientString = [secondaryComponents firstObject];
            
            self.toRecipients = [recipientString componentsSeparatedByString:@","];
            
            if ([secondaryComponents count] == 2) {
                NSDictionary *queryParameters = BRYMailToQueryStringToDictionary([secondaryComponents lastObject]);

                self.ccRecipients = [queryParameters[ParameterCC] componentsSeparatedByString:@","];
                self.bccRecipients = [queryParameters[ParameterBCC] componentsSeparatedByString:@","];
                self.subject = queryParameters[ParameterSubject];
                self.body = queryParameters[ParameterBody];
            }
        }
    }
    
    return self;
}

#pragma mark - Private

static NSDictionary *BRYMailToQueryStringToDictionary(NSString *string) {
    NSMutableDictionary *parameterDictionary = [NSMutableDictionary dictionary];

    NSArray *parameterStrings = [string componentsSeparatedByString:@"&"];
    
    for (NSString *parameterString in parameterStrings) {
        NSArray *parameterComponents = [parameterString componentsSeparatedByString:@"="];
        
        if ([parameterComponents count] == 2) {
            parameterDictionary[BRYMailToURLDecode(parameterComponents[0])] = BRYMailToURLDecode(parameterComponents[1]);
        }
    }
    
    return parameterDictionary;
}

static NSString *BRYMailToURLDecode(NSString *string) {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(NULL, (CFStringRef)string,
                                                                                    CFSTR("")));
}

@end
