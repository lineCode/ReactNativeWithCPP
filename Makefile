#
# Environment variables for overriding default behavior.
#

ifndef ANDROID_NDK_HOME
ANDROID_NDK_HOME = $(abspath $(dir $(realpath $(shell which ndk-build))))
endif

all: clean djinni android ios

	# freeze gyp at the last version with android support
./src/deps/gyp:
	git clone https://chromium.googlesource.com/external/gyp.git ./src/deps/gyp
	cd src/deps/gyp && git checkout -q 0bb67471bca068996e15b56738fa4824dfa19de0

djinni:
	cd src/deps/djinni/src && ./build

# Build IOS lib (.xcodeproj) for bridging
librncpp.xcodeproj: ./src/deps/gyp ./src/lib/librncpp.gyp ./src/deps/djinni/support-lib/support_lib.gyp ./src/djinni/helloworld.djinni
	sh run_djinni.sh
	src/deps/gyp/gyp --depth=. -f xcode -DOS=ios --generator-output ./build_ios -Isrc/deps/djinni/common.gypi ./src/lib/librncpp.gyp

# build android lib (.mk) for use in bridging
GypAndroid.mk: ./src/deps/gyp ./src/lib/librncpp.gyp ./src/deps/djinni/support-lib/support_lib.gyp ./src/djinni/helloworld.djinni
	@echo "Compiling GypAndroid.mk"
	sh ./run_djinni.sh
	ANDROID_BUILD_TOP=$(ANDROID_NDK_HOME) ./src/deps/gyp/gyp --depth=. -f android -DOS=android -I./src/deps/djinni/common.gypi ./src/lib/librncpp.gyp --root-target=librncpp_jni


# Building IOS project
ios:	librncpp.xcodeproj
# xcodebuild -project ios/ReactNativeCPP.xcodeproj \
#          -scheme ReactNativeCPP \
#          -configuration 'Debug' \
#          -sdk iphonesimulator

android:	GypAndroid.mk
	cd android/ && ./gradlew app:assembleDebug
	@echo "Apks produced at:"
	@python src/deps/djinni/example/glob.py ./ '*.apk'

clean:
	-ndk-build -C android/app/ clean
	@rm android/app/libs -rf
	@rm android/app/obj -rf
	@rm android/app/build -rf
	@rm ./djinni_build -rf
	@rm src/lib/librncpp_jni.target.mk -f
	@rm build_ios -rf
	@rm djinni-output-temp -rf
	@rm GypAndroid.mk -f
	@echo "Done"
