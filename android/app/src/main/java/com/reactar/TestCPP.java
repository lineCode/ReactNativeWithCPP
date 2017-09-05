package com.reactar;

import android.widget.Toast;

import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import java.util.Map;
import java.util.HashMap;

public class TestCPP extends ReactContextBaseJavaModule {
  private HelloWorld helloWorldInterface;

  static {
      System.loadLibrary("rncpp_jni");
    }


  public TestCPP(ReactApplicationContext reactContext) {
    super(reactContext);
    helloWorldInterface = HelloWorld.create();
  }

  @Override
  public String getName() {
    return "TestCPP";
  }

  @ReactMethod
  public void show() {
    String myString = helloWorldInterface.getHelloWorld() + "\n";
    Toast.makeText(getReactApplicationContext(), myString, Toast.LENGTH_LONG).show();
  }
}
