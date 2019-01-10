project 'testFramework.xcodeproj'

# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'testFramework' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks! 
    
  #pod "SQLCipher" 
  #pod "Realm"
  #pod "Alamofire"
  #pod "Firebase"
  #pod "AEXML"
  #pod "Crashlytics"
  #pod "OpenCV"
  #pod "SwipeCellKit"
  

  # Pods for testFramework

  target 'testFrameworkTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do | installer |
  print "SQLCipher: link Pods/Headers/sqlite3.h"
  system "mkdir -p Pods/Headers/Private && ln -s ../../SQLCipher/sqlite3.h Pods/Headers/Private"
end