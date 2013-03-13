//
//  BIMailToURIParserTests.m
//  BIMailToURIParserTests
//
//  Created by Bryan Irace on 3/13/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

#import "BIMailToURIParserTests.h"

#import "BIMailToURIParser.h"

@interface BIMailToURIParserTests()

@property (nonatomic, strong) BIMailToURIParser *parser;

@end

@implementation BIMailToURIParserTests

- (void)setUp {
    NSString *defaultString = @"mailto:foo@bar.com,foo2@bar.com?cc=foo3@bar.com&bcc=foo4@bar.com&"
            "subject=This%20is%20the%20subject&body=This%20is%20the%20body";
    
    self.parser = [[BIMailToURIParser alloc] initWithURL:[NSURL URLWithString:defaultString]];
}

- (void)testToRecipient {
    STAssertEqualObjects(self.parser.toRecipients[0], @"bryan@irace.me",
                         @"'To' recipient doesn't match");
}

- (void)testSecondaryToRecipient {
    STAssertEqualObjects(self.parser.toRecipients[1], @"bryan.irace@gmail.com",
                         @"Secondary 'To' recipient doesn't match");
}

- (void)testCCRecipient {
    STAssertEqualObjects(self.parser.ccRecipients[0], @"bryan@tumblr.com",
                         @"'CC' recipient doesn't match");
}

- (void)testBCCRecipient {
    STAssertEqualObjects(self.parser.bccRecipients[0], @"bryan.irace+bcc@gmail.com",
                         @"'BCC' recipient doesn't match");
}

- (void)testSubject {
    STAssertEqualObjects(self.parser.subject, @"This is the subject",
                         @"Subject doesn't match");
}

- (void)testBody {
    STAssertEqualObjects(self.parser.body, @"This is the body",
                         @"Body doesn't match");
}

- (void)testIsMailToURL {
    STAssertTrue([BIMailToURIParser isMailToURL:[NSURL URLWithString:@"mailto:"]],
                 @"Empty `mailto:` URL should be valid");
}

- (void)testDoesntCrashWithoutString {
    STAssertNotNil([[BIMailToURIParser alloc] initWithURL:[NSURL URLWithString:@"mailto:"]],
                   @"Empty `mailto:` URL should not be nil");
}

- (void)testDoesntCrashWithoutQueryString {
    STAssertNotNil([[BIMailToURIParser alloc] initWithURL:[NSURL URLWithString:@"mailto:bryan@irace.me?"]],
                   @"URL with empty query string should not be nil");
}

@end
