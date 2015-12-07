Pod::Spec.new do |s|
    s.name = 'AGRateView'
    s.version = '0.2'
    s.summary = 'AGRateView - This is UI component for iOS Application. By using it you can easy implement ratings in your application.'
    s.license = { :type => 'MIT', :file => 'LICENSE' }
    s.author = { 'Alexey Gubarev' => 'gubarev.lesha@gmail.com' }
    s.homepage     = 'https://github.com/ogubariev/AGRateView'
    s.platform = :ios, '7.0'
    s.source = { :git => 'https://github.com/ogubariev/AGRateView.git', :tag => s.version.to_s }
    s.public_header_files = 'AGRateView/*.h'

    s.framework = 'Foundation'
    s.requires_arc = true

    s.default_subspec = 'Core'

    s.subspec 'Core' do |ss|
        ss.source_files = 'AGRateView/*.{h,m}', 'AGRateView/Shapes/Default Shape/*.{h,m}'
    end

    s.subspec 'Shapes' do |ss|
        ss.source_files = 'AGRateView/Shapes/Custom Shapes/**/*.{h,m}'
    end
end