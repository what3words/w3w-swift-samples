for proj_file in *.xcodeproj; do
    proj_name="${proj_file%.*}"
    xcodebuild -resolvePackageDependencies
    xcodebuild -project $proj_name.xcodeproj -scheme $proj_name -sdk macosx -destination 'platform=OS X,arch=x86_64' PROD_API_KEY=$PROD_API_KEY build
done
