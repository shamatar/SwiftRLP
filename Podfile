def import_pods
  pod 'BigInt', '~> 3.1'
end


target 'SwiftRLP' do
  platform :osx, '10.11'
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  #use_frameworks!
  use_modular_headers!
  import_pods
  # Pods for SwiftRLP

  target 'SwiftRLPTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
