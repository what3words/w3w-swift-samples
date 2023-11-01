xcodebuild -project $folder.xcodeproj -scheme $folder -destination 'platform=OS X,arch=x86_64' PROD_API_KEY=$PROD_API_KEY build
