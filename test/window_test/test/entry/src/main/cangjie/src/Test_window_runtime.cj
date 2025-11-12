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


import ohos.window.{ColorSpace, Window, getLastWindow, SystemBarProperties, WindowCallbackType, Orientation,
    AvoidAreaType, WindowType, createWindow, findWindow, AvoidArea, TitleButtonRect, Configuration as WindowConfiguration,
    Rect as WindowRect}
import std.unittest.testmacro.*
import std.runtime.*
import std.unittest.*
import std.unittest.testmacro.*
import ohos.callback_invoke.Callback1Argument
import ohos.arkui.state_management.AppStorage
import ohos.business_exception.BusinessException
internal import ohos.hilog.Hilog

var callbackMsg: String = "trigger:"

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

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_GetMainWindowInfo() {
        try {
            sleepFor(1 * Duration.second)
            let windowInfo = getMainWindow().getWindowProperties()
        } catch (e: Exception) {
            Hilog.error(0, "CangjieUI-test", "case_GetMainWindowInfo " + e.toString())
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowColorSpace() {
        try {
            let windowClass = getMainWindow()
            windowClass.setWindowColorSpace(ColorSpace.WideGamut)
            let wideColorSpace = windowClass.getWindowColorSpace()
            windowClass.setWindowColorSpace(ColorSpace.Default)
            let defaultColorSpace = windowClass.getWindowColorSpace()
            @Expect(matchParse(wideColorSpace, ColorSpace.WideGamut))
            @Expect(matchParse(defaultColorSpace, ColorSpace.Default))
        } catch (e: Exception) {
            Hilog.error(0, "CangjieUI-test", "case_windowColorSpace " + e.toString())
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowSnapshot() {
        try {
            sleepFor(1.second)
            let map = getMainWindow().snapshot()
        } catch (e: Exception) {
            Hilog.error(0, "CangjieUI-test", "case_windowSnapshot " + e.toString())
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowRatio() {
        try {
            let windowClass = getMainWindow()
            windowClass.setAspectRatio(0.8f64)
            windowClass.resetAspectRatio()
        } catch (e: Exception) {
            Hilog.error(0, "CangjieUI-test", "case_windowRatio " + e.toString())
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowSettings() {
        try {
            sleepFor(1.second)
            let stageContext = getAbilityContext()
            let windowClass = getLastWindow(stageContext)
            let gamut = windowClass.isWindowSupportWideGamut()
            let showing = windowClass.isWindowShowing()
            windowClass.setWindowBrightness(0.5f32)
            windowClass.setWindowBackgroundColor("#00ff00")
            windowClass.setWindowSystemBarProperties(
                SystemBarProperties(
                    statusBarColor: "#ff00ff",
                    navigationBarColor: "#00ff00",
                    statusBarContentColor: "#ffffff",
                    navigationBarContentColor: "#00ffff"
                )
            )
        } catch (e: Exception) {
            Hilog.error(0, "CangjieUI-test", "case_windowSettings " + e.toString())
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowSettingTrue() {
        try {
            let callback = MyCallbackObject()
            let stageContext = getAbilityContext()
            let windowClass = getLastWindow(stageContext)
            windowClass.setWindowKeepScreenOn(true)
            windowClass.setWindowPrivacyMode(true)
            windowClass.setWindowTouchable(true)
            windowClass.setWindowFocusable(true)
            windowClass.setWindowLayoutFullScreen(true)
            windowClass.on(WindowCallbackType.KeyboardHeightChange, callback)
        } catch (e: Exception) {
            Hilog.error(0, "CangjieUI-test", "case_windowSettingTrue " + e.toString())
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowSettingFalse() {
        try {
            let stageContext = getAbilityContext()
            let windowClass = getLastWindow(stageContext)
            windowClass.setWindowKeepScreenOn(false)
            windowClass.setWindowPrivacyMode(false)
            windowClass.setWindowTouchable(false)
            windowClass.setWindowFocusable(false)
            windowClass.setWindowLayoutFullScreen(false)
            windowClass.off(WindowCallbackType.KeyboardHeightChange)
        } catch (e: Exception) {
            Hilog.error(0, "CangjieUI-test", "case_windowSettingFalse " + e.toString())
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowSettingOrientation() {
        try {
            let stageContext = getAbilityContext()
            let windowClass = getLastWindow(stageContext)
            windowClass.setPreferredOrientation(Orientation.Unspecified)
            windowClass.setPreferredOrientation(Orientation.Portrait)
            windowClass.setPreferredOrientation(Orientation.Landscape)
            windowClass.setPreferredOrientation(Orientation.PortraitInverted)
            windowClass.setPreferredOrientation(Orientation.LandscapeInverted)
            windowClass.setPreferredOrientation(Orientation.AutoRotationPortrait)
            windowClass.setPreferredOrientation(Orientation.AutoRotationLandscape)
            windowClass.setPreferredOrientation(Orientation.AutoRotationRestricted)
            windowClass.setPreferredOrientation(Orientation.AutoRotationPortraitRestricted)
            windowClass.setPreferredOrientation(Orientation.AutoRotationLandscapeRestricted)
            windowClass.setPreferredOrientation(Orientation.Locked)
            windowClass.setPreferredOrientation(Orientation.AutoRotation)
        } catch (e: Exception) {
            Hilog.error(0, "CangjieUI-test", "case_windowSettingOrientation " + e.toString())
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_GetMainWindowAvoidArea() {
        try {
            let area = getMainWindow().getWindowAvoidArea(AvoidAreaType.TypeSystem)
        } catch (e: Exception) {
            Hilog.error(0, "CangjieUI-test", "case_GetMainWindowAvoidArea " + e.toString())
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_WindowStageCreate() {
        let winStage = getWindowStage()
        let sub1 = winStage.createSubWindow("sub1")
        let sub2 = winStage.createSubWindow("sub2")
        sleepFor(1.second)
        let list = winStage.getSubWindow()
        @Expect(list.size == 2)
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_CreateWindow() {
        try {
            let mainWindow = getMainWindow()
            let mainId = mainWindow
                .getWindowProperties()
                .id
            let stageContext = getAbilityContext()
            let conf3 = WindowConfiguration(name: "test3", windowType: WindowType.TypeDialog, ctx: stageContext,
                displayId: 0, parentId: Int64(mainId))
            let win3 = createWindow(conf3)
            let result3 = findWindow("test3")
            @Expect(win3.getWindowProperties().id == result3.getWindowProperties().id)
        } catch (e: Exception) {
            Hilog.error(0, "CangjieUI-test", "case_CreateWindow " + e.toString())
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_CreateWindow1() {
        let mainWindow = getMainWindow()
        let id = mainWindow
            .getWindowProperties()
            .id
        let stageContext = getAbilityContext()
        createWindow(
            WindowConfiguration(name: "TypeApp", windowType: WindowType.TypeApp, ctx: stageContext, displayId: 0,
                parentId: Int64(id)))
        createWindow(
            WindowConfiguration(name: "TypeMain", windowType: WindowType.TypeMain, ctx: stageContext,
                displayId: 0, parentId: Int64(id)))
        createWindow(
            WindowConfiguration(name: "TypeFloat", windowType: WindowType.TypeFloat, ctx: stageContext, displayId: 0,
                parentId: Int64(id)))
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_getWindowAvoidArea() {
        func getWindowAvoidArea(window: Window, aaType: AvoidAreaType): Unit {
            try {
                window.getWindowAvoidArea(aaType)
            } catch (e: Exception) {
                Hilog.error(0, "CangjieUI-test", "case_getWindowAvoidArea " + e.toString())
            }
        }
        let mainWindow = getMainWindow()
        getWindowAvoidArea(mainWindow, AvoidAreaType.TypeCutout)
        getWindowAvoidArea(mainWindow, AvoidAreaType.TypeSystemGesture)
        getWindowAvoidArea(mainWindow, AvoidAreaType.TypeKeyboard)
        getWindowAvoidArea(mainWindow, AvoidAreaType.TypeNavigationIndicator)
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowMoveWindowTo() {
        try {
            let mainWindow = getMainWindow()
            mainWindow.moveWindowTo(0, 0)
        } catch (e: Exception) {
            Hilog.error(0, "CangjieUI-test", "case_windowMoveWindowTo" + e.toString())
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowResize() {
        try {
            sleepFor(1.second)
            let mainWindow = getMainWindow()
            let mainId = mainWindow
                .getWindowProperties()
                .id
            let stageContext = getAbilityContext()
            let conf3 = WindowConfiguration(name: "test7", windowType: WindowType.TypeDialog, ctx: stageContext,
                displayId: 0, parentId: Int64(mainId))
            let win3 = createWindow(conf3).resize(100, 100)
        } catch (e: Exception) {
            Hilog.error(0, "CangjieUI-test", "case_windowResize" + e.toString())
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowMinimize() {
        let mainWindow = getMainWindow()

        mainWindow.minimize()
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_struct() {
        let titleButtonRect = TitleButtonRect(right: 1, top: 1, width: 1, height: 1)
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_AvoidAreaStruct() {
        try {
            var avoidArea: AvoidArea = AvoidArea(visible: false, leftRect: WindowRect(left: 0, top: 0, width: 0,
                height: 0), topRect: WindowRect(left: 0, top: 0, width: 0, height: 0),
                rightRect: WindowRect(left: 0, top: 0, width: 0, height: 0),
                bottomRect: WindowRect(left: 0, top: 0, width: 0, height: 0))
        } catch (e: Exception) {
            Hilog.error(0, "CangjieUI-test", "case_AvoidAreaStruct " + e.toString())
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_on_off(): Unit {
        let window = getMainWindow()
        let callback = MyCallbackObject()
        // test on twice
        window.on(WindowCallbackType.KeyboardHeightChange, callback)
        window.on(WindowCallbackType.KeyboardHeightChange, callback)
        // test on invalid callbackType
        // test off
        window.off(WindowCallbackType.KeyboardHeightChange)
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowDestroyWindow() {
        try {
            let mainWindow = getMainWindow()
            mainWindow.destroyWindow()
        } catch (e: Exception) {
            Hilog.error(0, "CangjieUI-test", "case_windowDestroyWindow" + e.toString())
            @Expect(false)
        }
    }
}
