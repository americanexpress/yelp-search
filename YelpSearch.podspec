# Be sure to run `pod lib lint YelpSearch.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "YelpSearch"
  s.version          = "0.1.0"
  s.summary          = "Search for businesses on Yelp"

# This description is used to generate tags and improve search results.
  s.description      = <<-DESC
                       A utility to search for businesses using the Yelp Search API
                       DESC

  s.homepage         = "https://github.com/americanexpress/yelpsearch"
  s.license          = 'Apache License, Version 2.0'
  s.author           = { "Ace Ellett" => "Ace.Ellett@aexp.com" }
  s.source           = { :git => "https://github.com/americanexpress/yelpsearch.git", :tag => s.version.to_s }
  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'YelpSearch' => ['Pod/Assets/*.png']
  }
  s.dependency 'OAuthSwift', '~> 0.5.0'
  s.dependency 'SwiftyJSON', '~> 2.3.1'
  s.dependency 'Alamofire', '~> 3.0'
end
