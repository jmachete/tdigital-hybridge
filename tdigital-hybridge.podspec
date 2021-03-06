Pod::Spec.new do |s|
    s.name                      = "tdigital-hybridge"
    s.version                   = '1.0.0'
    s.summary                   = "Library for access to native environment from a webview scope."

    s.license                   = "Copyright (c) 2013 Telefónica Digital - Enjoy @mobile. All rights reserved."
    s.homepage                  = "https://pdihub.hi.inet/mca/tdigital-hybridge.git"
    s.author                    = { "dgs30" => "dgs30@tid.es" }

    s.source                    = { :git => 'https://pdihub.hi.inet/mca/tdigital-hybridge.git',  :branch => 'develop'}

    s.platform                  = :ios
    s.ios.deployment_target     = '6.0'

    s.source_files              = 'ios/Hybridge/Hybridge/*.{h,m}'

    s.xcconfig                  =  { 'LIBRARY_SEARCH_PATHS' => '"$(SRCROOT)/Pods/tdigital-hybridge"',
                                    'GCC_PREPROCESSOR_DEFINITIONS' => '$(CONFIGURATION)=1' }

    s.requires_arc              = true

    s.framework                 = "Foundation", "UIKit"
end