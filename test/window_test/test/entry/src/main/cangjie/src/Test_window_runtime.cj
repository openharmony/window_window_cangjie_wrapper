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


import kit.ArkUI.{Configuration as Conf, getLastWindow, WindowOrientation, createWindow, WindowType, SystemBarProperties, 
    ColorSpace, AvoidAreaType, findWindow, Size as windowSize, TitleButtonRect, AvoidArea, WindowRect, Window}
import std.unittest.testmacro.*
import ohos.base.*
import ohos.image.*
import std.runtime.*
import std.sync.*
import std.time.*
import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import ohos.base.*
import ohos.window.WindowStage
import ohos.state_manage.AppStorage

class MyCallbackObject <: Callback1Argument<UInt32> {
    let callback_: (UInt32) -> Unit
    public init(callback: (UInt32) -> Unit) {
        callback_ = callback
    }
    public func invoke(val: UInt32): Unit {
        callback_(val)
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
            case (ColorSpace.WIDE_GAMUT, ColorSpace.WIDE_GAMUT) => true
            case (ColorSpace.DEFAULT, ColorSpace.DEFAULT) => true
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
            logger.error("case_GetMainWindowInfo " + e.toString())
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowColorSpace() {
        try {
            let windowClass = getMainWindow()
            windowClass.setWindowColorSpace(ColorSpace.WIDE_GAMUT)
            let wideColorSpace = windowClass.getWindowColorSpace()
            windowClass.setWindowColorSpace(ColorSpace.DEFAULT)
            let defaultColorSpace = windowClass.getWindowColorSpace()
            @Expect(matchParse(wideColorSpace, ColorSpace.WIDE_GAMUT))
            @Expect(matchParse(defaultColorSpace, ColorSpace.DEFAULT))
        } catch (e: Exception) {
            logger.error("case_windowColorSpace " + e.toString())
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
            logger.error("case_windowSnapshot " + e.toString())
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
            logger.error("case_windowRatio " + e.toString())
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowSettings() {
        try {
            sleepFor(1.second)
            let windowClass = getLastWindow(getStageContext())
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
            windowClass.setWindowSystemBarEnable(["status", "navigation"])
        } catch (e: Exception) {
            logger.error("case_windowSettings " + e.toString())
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowSettingTrue() {
        try {
            let callback = MyCallbackObject({val: UInt32 => logger.info("keyboard raise to ${val}")})
            let windowClass = getLastWindow(getStageContext())
            windowClass.setWindowKeepScreenOn(true)
            windowClass.setWindowPrivacyMode(true)
            windowClass.setWindowTouchable(true)
            windowClass.setWindowFocusable(true)
            windowClass.setWindowLayoutFullScreen(true)
            windowClass.on("keyboardHeightChange", callback)
        } catch (e: Exception) {
            logger.error("case_windowSettingTrue " + e.toString())
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowSettingFalse() {
        try {
            let windowClass = getLastWindow(getStageContext())
            windowClass.setWindowKeepScreenOn(false)
            windowClass.setWindowPrivacyMode(false)
            windowClass.setWindowTouchable(false)
            windowClass.setWindowFocusable(false)
            windowClass.setWindowLayoutFullScreen(false)
            windowClass.off("keyboardHeightChange")
        } catch (e: Exception) {
            logger.error("case_windowSettingFalse " + e.toString())
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowSettingOrientation() {
        try {
            let windowClass = getLastWindow(getStageContext())
            windowClass.setPreferredOrientation(WindowOrientation.UNSPECIFIED)
            windowClass.setPreferredOrientation(WindowOrientation.PORTRAIT)
            windowClass.setPreferredOrientation(WindowOrientation.LANDSCAPE)
            windowClass.setPreferredOrientation(WindowOrientation.PORTRAIT_INVERTED)
            windowClass.setPreferredOrientation(WindowOrientation.LANDSCAPE_INVERTED)
            windowClass.setPreferredOrientation(WindowOrientation.AUTO_ROTATION_PORTRAIT)
            windowClass.setPreferredOrientation(WindowOrientation.AUTO_ROTATION_LANDSCAPE)
            windowClass.setPreferredOrientation(WindowOrientation.AUTO_ROTATION_RESTRICTED)
            windowClass.setPreferredOrientation(WindowOrientation.AUTO_ROTATION_PORTRAIT_RESTRICTED)
            windowClass.setPreferredOrientation(WindowOrientation.AUTO_ROTATION_LANDSCAPE_RESTRICTED)
            windowClass.setPreferredOrientation(WindowOrientation.LOCKED)
            windowClass.setPreferredOrientation(WindowOrientation.AUTO_ROTATION)
        } catch (e: Exception) {
            logger.error("case_windowSettingOrientation " + e.toString())
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_GetMainWindowAvoidArea() {
        try {
            let area = getMainWindow().getWindowAvoidArea(AvoidAreaType.TYPE_SYSTEM)
        } catch (e: Exception) {
            logger.error("case_GetMainWindowAvoidArea " + e.toString())
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
            let mainId = mainWindow.getWindowProperties().id
            let conf3 = Conf("test3", WindowType.TYPE_DIALOG, getStageContext(), displayId: 0, parentId: Int64(mainId))
            let win3 = createWindow(conf3)
            let result3 = findWindow("test3")
            @Expect(win3.getWindowProperties().id == result3.getWindowProperties().id)
        } catch (e: Exception) {
            logger.error("case_CreateWindow " + e.toString())
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_CreateWindow1() {
        func createWindow(name: String, windowType: WindowType, id: UInt32): Unit {
            try {
                let config = Conf(name, windowType, getStageContext(), displayId: 0, parentId: Int64(id))
                createWindow(config)
            } catch (e: Exception) {
                logger.error("case_CreateWindow " + e.toString())
            }
        }

        let mainWindow = getMainWindow()
        let id = mainWindow.getWindowProperties().id
        createWindow("TYPE_APP", WindowType.TYPE_APP, id)
        createWindow("TYPE_SYSTEM_ALERT", WindowType.TYPE_SYSTEM_ALERT, id)
        createWindow("TYPE_FLOAT", WindowType.TYPE_FLOAT, id)
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_getWindowAvoidArea() {
        func getWindowAvoidArea(window: Window, aaType: AvoidAreaType): Unit {
            try {
                window.getWindowAvoidArea(aaType)
            } catch (e: Exception) {
                logger.error("case_getWindowAvoidArea " + e.toString())
            }
        }
        let mainWindow = getMainWindow()
        getWindowAvoidArea(mainWindow, AvoidAreaType.TYPE_CUTOUT)
        getWindowAvoidArea(mainWindow, AvoidAreaType.TYPE_SYSTEM_GESTURE)
        getWindowAvoidArea(mainWindow, AvoidAreaType.TYPE_KEYBOARD)
        getWindowAvoidArea(mainWindow, AvoidAreaType.TYPE_NAVIGATION_INDICATOR)
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowMoveWindowTo() {
        try {
            let mainWindow = getMainWindow()
            mainWindow.moveWindowTo(0, 0)
        } catch (e: Exception) {
            logger.error("case_windowMoveWindowTo" + e.toString())
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowResize() {
        try {
            sleepFor(1.second)
            let mainWindow = getMainWindow()
            let mainId = mainWindow.getWindowProperties().id
            let conf3 = Conf("test7", WindowType.TYPE_DIALOG, getStageContext(), displayId: 0, parentId: Int64(mainId))
            let win3 = createWindow(conf3).resize(100, 100)
        } catch (e: Exception) {
            logger.error("case_windowResize" + e.toString())
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
        let size = windowSize(1, 1)
        let titleButtonRect = TitleButtonRect(1, 1, 1, 1)
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_AvoidAreaStruct() {
        try {
            var avoidArea: AvoidArea = AvoidArea(false, WindowRect(0, 0, 0, 0), WindowRect(0, 0, 0, 0),
                WindowRect(0, 0, 0, 0), WindowRect(0, 0, 0, 0))
        } catch (e: Exception) {
            logger.error("case_AvoidAreaStruct " + e.toString())
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_on_off(): Unit {
        let window = getMainWindow()
        let callback = MyCallbackObject({val: UInt32 => logger.info("keyboard raise to ${val}")})
        // test on twice
        window.on("keyboardHeightChange", callback)
        window.on("keyboardHeightChange", callback)
        // test on invalid callbackType
        window.on("invalid", callback)
        // test off
        window.off("keyboardHeightChange")
        window.off("invalid")
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func test_windowDestroyWindow() {
        try {
            let mainWindow = getMainWindow()
            mainWindow.destroyWindow()
        } catch (e: Exception) {
            logger.error("case_windowDestroyWindow" + e.toString())
            @Expect(false)
        }
    }
}
