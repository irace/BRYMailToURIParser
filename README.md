# BIMailToURIParser

Simple Objective-C parser for `mailto` URIs. With tests!

```objectivec
BIMailToURIParser *parser = [[BIMailToURIParser alloc] initWithURL:
                             [NSURL URLWithString:@"mailto:bryan@irace.me?subject=Hey"]];
NSArray *recipients = parser.toRecipients;
NSArray *ccRecipients = parser.ccRecipients;
NSArray *bccRecipients = parser.bccRecipients;
NSString *subject = parser.subject;
NSString *body = parser.body;
```

## License
Available for use under the MIT license: [http://bryan.mit-license.org](http://bryan.mit-license.org)
