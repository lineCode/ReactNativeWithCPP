{
    "targets": [
        {
            "target_name": "librncpp_jni",
            "type": "shared_library",
            "dependencies": [
              "../deps/djinni/support-lib/support_lib.gyp:djinni_jni",
            ],
            "ldflags": [ "-llog", "-Wl,--build-id,--gc-sections,--exclude-libs,ALL" ],
            "sources": [
              "../deps/djinni/support-lib/jni/djinni_main.cpp",
              "<!@(python ../deps/djinni/example/glob.py ../../djinni_build/jni   '*.cpp')",
              "<!@(python ../deps/djinni/example/glob.py ../../djinni_build/cpp   '*.cpp')",
              "<!@(python ../deps/djinni/example/glob.py ../cpp '*.cpp' '*.hpp')",
            ],
            "include_dirs": [
              "../../djinni_build/jni",
              "../../djinni_build/cpp",
              "../cpp",
            ],
        },
        {
            "target_name": "librncpp_objc",
            "type": 'static_library',
            "dependencies": [
              "../deps/djinni/support-lib/support_lib.gyp:djinni_objc",
            ],
            "sources": [
              "<!@(python ../deps/djinni/example/glob.py ../../djinni_build/objc  '*.cpp' '*.mm' '*.m')",
              "<!@(python ../deps/djinni/example/glob.py ../../djinni_build/cpp   '*.cpp')",
              "<!@(python ../deps/djinni/example/glob.py ../cpp '*.cpp' '*.hpp')",
            ],
            "include_dirs": [
              "../../djinni_build/objc",
              "../../djinni_build/cpp",
              "../cpp",
            ],
        },
    ],
}
