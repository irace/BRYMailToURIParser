//
//  BRYMailToURIParser.h
//  BRYMailToURIParser
//
//  Created by Bryan Irace on 3/13/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRYMailToURIParser : NSObject

@property (nonatomic, copy, readonly) NSArray *toRecipients;
@property (nonatomic, copy, readonly) NSArray *ccRecipients;
@property (nonatomic, copy, readonly) NSArray *bccRecipients;
@property (nonatomic, copy, readonly) NSString *subject;
@property (nonatomic, copy, readonly) NSString *body;

+ (BOOL)isMailToURL:(NSURL *)URL;

- (id)initWithURL:(NSURL *)URL;

@end
