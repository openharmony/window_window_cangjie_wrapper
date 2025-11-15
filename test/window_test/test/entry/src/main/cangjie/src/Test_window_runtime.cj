/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * Created on 2024/1/29
 */
package ohos_app_cangjie_entry

import std.unittest.testmacro.*
import std.runtime.*
import std.unittest.*
import ohos.ui_test.*
import std.unittest.testmacro.*
import ohos.callback_invoke.Callback1Argument
import ohos.arkui.state_management.AppStorage
import ohos.business_exception.BusinessException
internal import ohos.hilog.Hilog
import stdx.encoding.json.*
import ohos.window.{ColorSpace, Window}

var callbackMsg: String = "trigger:"
var wideColorSpace: ColorSpace = ColorSpace.WideGamut

class MyCallbackObject <: Callback1Argument<UInt32> {
    public init() {}

    public open func invoke(err: ?BusinessException, event: UInt32): Unit {
        callbackMsg += "\nSubWindowClose;"
        if (let Some(v) <- err) {
            callbackMsg += "error: ${err.toString()}"
        }
        Hilog.info(1, "Cangjie-App", callbackMsg)
    }
}

public func getMainWindow(): Window {
    getWindowStage().getMainWindow()
}

public func getWindowStage(): WindowStage {
    match (AppStorage.get<WindowStage>("windowStage")) {
        case None => throw Exception("failed to get window stage")
        case Some(windowStage) => windowStage
    }
}

@Test
class Test_window_runtime {
    prop driver: Driver {
        get() {
            OpenHarmonyTestRunner.driver
        }
    }

    func matchParse(v1: ColorSpace, v2: ColorSpace) {
        match ((v1, v2)) {
            case (ColorSpace.WideGamut, ColorSpace.WideGamut) => true
            case (ColorSpace.Default, ColorSpace.Default) => true
            case _ => false
        }
    }

    override func afterAll(): Unit {
        GC()
        sleep(Duration.second)
    }

    func clickButton(buttonId: String) {
        driver.delayMs(300)
        Hilog.info(1,"Test_window_runtime","click ${buttonId}")
        let button = driver.waitForComponent(On().id(buttonId),500).getOrThrow()
        button.click()
        driver.delayMs(200)
    }

    func getContentFromText(textId: String): String {
        var inspector = getInspectorByKey(textId)
        var jsonObject = JsonValue.fromStr(inspector).asObject()
        var attrs = jsonObject.get("$attrs").getOrThrow().asObject()
        attrs.get("content").getOrThrow().toString()
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_GetMainWindowInfo() {
        clickButton("test_GetMainWindowInfo")
        var prop2: String = getContentFromText("message")
        @Expect(prop2.contains("windowRect: [0, 0, 1260, 2720]"))
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowColorSpace() {
        clickButton("test_windowColorSpace")
        var prop2: String = getContentFromText("message")
        @Expect(prop2.contains("windowColorSpace success"))
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowSnapshot() {
        clickButton("test_windowSnapshot")
        var prop2: String = getContentFromText("message")
        @Expect(prop2.contains("windowSnapshot success"))
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowRatio() {
        clickButton("test_windowRatio")
        var prop2: String = getContentFromText("message")
        @Expect(prop2.contains("windowRatio success"))
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowSettingOrientation() {
        clickButton("test_windowSettingOrientation")
        var prop2: String = getContentFromText("message")
        @Expect(prop2.contains("windowSettingOrientation success"))
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_GetMainWindowAvoidArea() {
        clickButton("test_GetMainWindowAvoidArea")
        var prop2: String = getContentFromText("message")
        @Expect(prop2.contains("GetMainWindowAvoidArea success"))
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_WindowStageCreate() {
        clickButton("test_WindowStageCreate")
        var prop2: String = getContentFromText("message")
        @Expect(prop2.contains("2"))
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_CreateWindow() {
        clickButton("test_CreateWindow")
        var prop2: String = getContentFromText("message")
        @Expect(prop2.contains("true"))
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_getWindowAvoidArea() {
        clickButton("test_getWindowAvoidArea")
        var prop2: String = getContentFromText("message")
        @Expect(prop2.contains("getWindowAvoidArea success"))
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowMoveWindowTo() {
        clickButton("test_windowMoveWindowTo")
        var prop2: String = getContentFromText("message")
        @Expect(prop2.contains("windowMoveWindowTo success"))
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowResize() {
        clickButton("test_windowResize")
        var prop2: String = getContentFromText("message")
        @Expect(prop2.contains("windowResize success"))
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_struct() {
        clickButton("test_struct")
        var prop2: String = getContentFromText("message")
        @Expect(prop2.contains("struct success"))
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_AvoidAreaStruct() {
        clickButton("test_AvoidAreaStruct")
        var prop2: String = getContentFromText("message")
        @Expect(prop2.contains("visible: false, leftRect: [0, 0, 0, 0]"))
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_on_off(): Unit {
        clickButton("test_on_off")
        var prop2: String = getContentFromText("message")
        @Expect(prop2.contains("on_off success"))
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowDestroyWindow() {
        clickButton("test_windowDestroyWindow")
        var prop2: String = getContentFromText("message")
        @Expect(prop2.contains("windowDestroyWindow success"))
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowSettings() {
        clickButton("test_windowSettings")
        var prop2: String = getContentFromText("message")
        @Expect(prop2.contains("windowSettings success"))
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowSettingTrue() {
        clickButton("test_windowSettingTrue")
        var prop2: String = getContentFromText("message")
        @Expect(prop2.contains("windowSettingTrue success"))
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowSettingFalse() {
        clickButton("test_windowSettingFalse")
        var prop2: String = getContentFromText("message")
        @Expect(prop2.contains("windowSettingFalse success"))
    }
}
