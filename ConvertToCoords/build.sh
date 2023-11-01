folder=basename $(pwd)
xcodebuild -project $folder.xcodeproj -scheme $folder -sdk macosx -destination 'platform=OS X,arch=x86_64' PROD_API_KEY=$PROD_API_KEY build
