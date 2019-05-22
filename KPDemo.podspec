Pod::Spec.new do |s|
    s.name     = 'KPDemo'
    s.version  = '0.0.1'
    s.license  = 'MIT'
    s.summary  = "An autolayout anchor wrapper."
    s.homepage = 'https://github.com/yume190/KPDemo'
    s.authors  = { 'yume190' => 'yume190@gmail.com' }
    s.social_media_url = "https://www.facebook.com/yume190"
    s.source   = { :git => 'https://github.com/yume190/KPDemo.git', :tag => s.version }
  
    s.swift_version = '4.2'
    s.ios.deployment_target = '9.0'
    s.source_files = [
        'KPDemo/Cell/*.swift',
        'KPDemo/Core/CellProtocol/*.swift',
        'KPDemo/Core/Config/*.swift',
        'KPDemo/Core/Demo/*.swift',
        'KPDemo/Core/DemoItem/*.swift',
        'KPDemo/OtherTool/*.swift'
    ]
  end