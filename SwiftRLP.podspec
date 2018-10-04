Pod::Spec.new do |s|
s.name             = "SwiftRLP"
s.version          = "1.0.1"
s.summary          = "RLP implementation in vanilla Swift for iOS ans macOS"

s.description      = <<-DESC
RLP implementation in vanilla Swift, intended for mobile developers of wallets, Dapps and Web3.0
DESC

s.homepage         = "https://github.com/shamatar/SwiftRLP"
s.license          = 'Apache License 2.0'
s.author           = { "Alex Vlasov" => "alex.m.vlasov@gmail.com" }
s.source           = { :git => 'https://github.com/shamatar/SwiftRLP.git', :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/shamatar'

s.swift_version = '4.1'
s.module_name = 'SwiftRLP'
s.ios.deployment_target = "9.0"
s.osx.deployment_target = "10.11"
s.source_files = "Classes/RLP.swift",
s.public_header_files = "SwiftRLP/SwiftRLP.h"
s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }

s.dependency 'BigInt', '~> 3.1'
end
