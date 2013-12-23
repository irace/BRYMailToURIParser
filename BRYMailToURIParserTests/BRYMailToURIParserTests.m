//
//  BRYMailToURIParserTests.m
//  BRYMailToURIParserTests
//
//  Created by Bryan Irace on 3/13/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

#import "BRYMailToURIParserTests.h"

#import "BRYMailToURIParser.h"

@interface BRYMailToURIParserTests()

@property (nonatomic, strong) BRYMailToURIParser *parser;

@end

@implementation BRYMailToURIParserTests

- (void)setUp {
    NSString *defaultString = @"mailto:foo@bar.com,foo2@bar.com?cc=foo3@bar.com&bcc=foo4@bar.com&"
    "subject=This%20is%20the%20subject&body=This%20is%20the%20body";
    
    self.parser = [[BRYMailToURIParser alloc] initWithURL:
                   [NSURL URLWithString:defaultString]];
}

- (void)testToRecipient {
    STAssertEqualObjects(self.parser.toRecipients[0], @"foo@bar.com",
                         @"'To' recipient doesn't match");
}

- (void)testSecondaryToRecipient {
    STAssertEqualObjects(self.parser.toRecipients[1], @"foo2@bar.com",
                         @"Secondary 'To' recipient doesn't match");
}

- (void)testCCRecipient {
    STAssertEqualObjects(self.parser.ccRecipients[0], @"foo3@bar.com",
                         @"'CC' recipient doesn't match");
}

- (void)testBCCRecipient {
    STAssertEqualObjects(self.parser.bccRecipients[0], @"foo4@bar.com",
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

- (void)testIsNotMailToURL {
    STAssertFalse([BRYMailToURIParser isMailToURL:[NSURL URLWithString:@"mailto"]],
                  @"Empty `mailto` URL should not be valid");
}

- (void)testIsMailToURL {
    STAssertTrue([BRYMailToURIParser isMailToURL:[NSURL URLWithString:@"mailto:"]],
                 @"Empty `mailto:` URL should be valid");
}

- (void)testDoesntCrashWithoutString {
    STAssertNotNil([[BRYMailToURIParser alloc] initWithURL:[NSURL URLWithString:@"mailto:"]],
                   @"Empty `mailto:` URL should not be nil");
}

- (void)testDoesntCrashWithoutQueryString {
    STAssertNotNil([[BRYMailToURIParser alloc] initWithURL:[NSURL URLWithString:@"mailto:bryan@irace.me?"]],
                   @"URL with empty query string should not be nil");
}

- (void)testDoesntCrashWithNilURL {
    STAssertNotNil([[BRYMailToURIParser alloc] initWithURL:nil], @"Nil URL should not crash");
}

- (void)testNilIsNotMailToLink {
    // For Chris Haseman since he loves that you can do `[[nil scheme] isEqualToString@"mailto"]` without nil checks
    
    STAssertFalse([BRYMailToURIParser isMailToURL:nil], @"Nil URL is not a `mailto` link");
}

@end
