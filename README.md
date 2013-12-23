# BRYMailToURIParser

Simple Objective-C parser for `mailto` URIs. With tests!

## Installation

Via [CocoaPods](http://cocoapods.org), of course:

    pod install BRYMailToURIParser

## Usage

```objectivec
BIMailToURIParser *parser = [[BIMailToURIParser alloc] initWithURL:
                             [NSURL URLWithString:@"mailto:bryan@domain.me?subject=Hey"]];
NSArray *recipients = parser.toRecipients;
NSArray *ccRecipients = parser.ccRecipients;
NSArray *bccRecipients = parser.bccRecipients;
NSString *subject = parser.subject;
NSString *body = parser.body;
```

## License
Available for use under the MIT license: [http://bryan.mit-license.org](http://bryan.mit-license.org)
