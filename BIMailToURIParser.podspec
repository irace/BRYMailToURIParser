Pod::Spec.new do |s|
  s.name         = 'BIMailToURIParser'
  s.version      = '0.1.0'
  s.summary      = 'Simple Objective-C parser for mailto URIs'
  s.author       = { 'Bryan Irace' => 'bryan@irace.me' }
  s.license      = 'MIT'
  s.source_files = 'BIMailToURIParser'
  s.requires_arc = true
  s.ios.deployment_target = '5.0'
  s.frameworks   = 'Foundation'
end
