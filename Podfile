# Uncomment the next line to define a global platform for your project
platform :macos, '10.13'

target 'SPV' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks! #:linkage => :static
  pod 'SnapKit'
  pod 'swift-mdk'
  # Pods for SPV

  target 'QLView' do
    #use_frameworks! :linkage => :static
    pod 'SnapKit'
    pod 'swift-mdk'
  end

  target 'SPVBase' do
  end

  target 'SPVTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SPVUITests' do
    # Pods for testing
  end

end
