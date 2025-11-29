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

package ohos_app_cangjie_entry

import ohos.window.{ColorSpace, Window, getLastWindow, SystemBarProperties, WindowCallbackType, Orientation,
    AvoidAreaType, WindowType, createWindow, findWindow, AvoidArea, TitleButtonRect, Configuration as WindowConfiguration,
    Rect as WindowRect}
internal import ohos.arkui.component.*
internal import ohos.arkui.component.loadNativeView
internal import ohos.base.*
internal import ohos.arkui.state_management.*
import ohos.arkui.state_macro_manage.Entry
import ohos.arkui.state_macro_manage.Component
import ohos.arkui.state_macro_manage.State
import ohos.arkui.state_macro_manage.r

@Entry
@Component
class EntryView {
    @State
    var msg: String = "Hello Cangjie"
    func build() {
        Column {
            Text(this.msg).id("message")
            Row() {
                Button("GetMainWindowInfo")
                    .id("test_GetMainWindowInfo")
                    .onClick ({ e
                        =>
                        Hilog.error(0, "Test_window_runtime", "test_GetMainWindowInfo start")
                        var window = getMainWindow()
                        let windowInfo = window.getWindowProperties()
                        this.msg = "windowRect: [${windowInfo.windowRect.left}, ${windowInfo.windowRect.top}, ${windowInfo.windowRect.width}, ${windowInfo.windowRect.height}]"
                        Hilog.error(0, "Test_window_runtime", "test_GetMainWindowInfo end, msg: ${this.msg}")
                    })
                    .width(33.percent)
                Button("windowColorSpace")
                    .id("test_windowColorSpace")
                    .onClick ({ e
                        =>
                        Hilog.error(0, "Test_window_runtime", "test_windowColorSpace start")
                        let windowClass = getMainWindow()
                        windowClass.setWindowColorSpace(ColorSpace.Default)
                        let defaultColorSpace = windowClass.getWindowColorSpace()
                        windowClass.setWindowColorSpace(ColorSpace.WideGamut)
                        wideColorSpace = windowClass.getWindowColorSpace()
                        this.msg = "windowColorSpace success"
                        Hilog.error(0, "Test_window_runtime", "test_windowColorSpace end, msg: ${this.msg}")
                    })
                    .width(33.percent)
                Button("windowSnapshot")
                    .id("test_windowSnapshot")
                    .onClick ({ e
                        =>
                        Hilog.error(0, "Test_window_runtime", "test_windowSnapshot start")
                        let map = getMainWindow().snapshot()
                        Hilog.error(0, "Test_window_runtime", "test_windowSnapshot end, msg: ${this.msg}")
                        this.msg = "windowSnapshot success"
                    })
                    .width(33.percent)
            }
            Row() {
                Button("windowRatio")
                    .id("test_windowRatio")
                    .onClick ({ e
                        =>
                        Hilog.error(0, "Test_window_runtime", "test_windowRatio start")
                        let windowClass = getMainWindow()
                        windowClass.setAspectRatio(0.8f64)
                        windowClass.resetAspectRatio()
                        this.msg = "windowRatio success"
                        Hilog.error(0, "Test_window_runtime", "test_windowRatio end, msg: ${this.msg}")
                    })
                    .width(33.percent)
                Button("windowSettings")
                    .id("test_windowSettings")
                    .onClick ({ e
                        =>
                        Hilog.error(0, "Test_window_runtime", "test_windowSettings start")
                        let stageContext = getAbilityContext()
                        let windowClass = getLastWindow(stageContext)
                        let gamut = windowClass.isWideGamutSupported()
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
                        this.msg = "windowSettings success"
                        Hilog.error(0, "Test_window_runtime", "test_windowSettings end, msg: ${this.msg}")
                    })
                    .width(33.percent)
                Button("windowSettingTrue")
                    .id("test_windowSettingTrue")
                    .onClick ({ e
                        =>
                        Hilog.error(0, "Test_window_runtime", "test_windowSettingTrue start")
                        let callback = MyCallbackObject()
                        let stageContext = getAbilityContext()
                        let windowClass = getLastWindow(stageContext)
                        windowClass.setWindowKeepScreenOn(true)
                        windowClass.setWindowPrivacyMode(true)
                        windowClass.setWindowTouchable(true)
                        windowClass.setWindowFocusable(true)
                        windowClass.setWindowLayoutFullScreen(true)
                        windowClass.on(WindowCallbackType.KeyboardHeightChange, callback)
                        this.msg = "windowSettingTrue success"
                        Hilog.error(0, "Test_window_runtime", "test_windowSettingTrue end, msg: ${this.msg}")
                    })
                    .width(33.percent)
            }
            Row() {
                Button("windowSettingFalse")
                    .id("test_windowSettingFalse")
                    .onClick ({ e
                        =>
                        Hilog.error(0, "Test_window_runtime", "test_windowSettingFalse start")
                        let stageContext = getAbilityContext()
                        let windowClass = getLastWindow(stageContext)
                        windowClass.setWindowKeepScreenOn(false)
                        windowClass.setWindowPrivacyMode(false)
                        windowClass.setWindowTouchable(false)
                        windowClass.setWindowFocusable(false)
                        windowClass.setWindowLayoutFullScreen(false)
                        windowClass.off(WindowCallbackType.KeyboardHeightChange)
                        this.msg = "windowSettingFalse success"
                        Hilog.error(0, "Test_window_runtime", "test_windowSettingFalse end, msg: ${this.msg}")
                    })
                    .width(33.percent)
                Button("windowSettingOrientation")
                    .id("test_windowSettingOrientation")
                    .onClick ({ e
                        =>
                        Hilog.error(0, "Test_window_runtime", "test_windowSettingOrientation start")
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
                        this.msg = "windowSettingOrientation success"
                        Hilog.error(0, "Test_window_runtime", "test_windowSettingOrientation end, msg: ${this.msg}")
                    })
                    .width(33.percent)
                Button("GetMainWindowAvoidArea")
                    .id("test_GetMainWindowAvoidArea")
                    .onClick ({ e
                        =>
                        Hilog.error(0, "Test_window_runtime", "test_GetMainWindowAvoidArea start")
                        let area = getMainWindow().getWindowAvoidArea(AvoidAreaType.TypeSystem)
                        this.msg = "GetMainWindowAvoidArea success"
                        Hilog.error(0, "Test_window_runtime", "test_GetMainWindowAvoidArea end, msg: ${this.msg}")
                    })
                    .width(33.percent)
            }


            Row() {
                Button("WindowStageCreate")
                    .id("test_WindowStageCreate")
                    .onClick ({ e
                        =>
                        Hilog.error(0, "Test_window_runtime", "test_WindowStageCreate start")
                        let winStage = getWindowStage()
                        let sub1 = winStage.createSubWindow("sub1")
                        let sub2 = winStage.createSubWindow("sub2")
                        let list = winStage.getSubWindow()
                        this.msg = "${list.size}"
                        Hilog.error(0, "Test_window_runtime", "test_WindowStageCreate end, msg: ${this.msg}")
                    })
                    .width(33.percent)
                Button("CreateWindow")
                    .id("test_CreateWindow")
                    .onClick ({ e
                        =>
                        Hilog.error(0, "Test_window_runtime", "test_CreateWindow start")
                        let mainWindow = getMainWindow()
                        let mainId = mainWindow
                            .getWindowProperties()
                            .id
                        let stageContext = getAbilityContext()
                        let conf3 = WindowConfiguration(name: "test3", windowType: WindowType.TypeDialog, ctx: stageContext,
                            displayId: 0, parentId: Int64(mainId))
                        let win3 = createWindow(conf3)
                        let result3 = findWindow("test3")
                        this.msg = "${win3.getWindowProperties().id == result3.getWindowProperties().id}"
                        Hilog.error(0, "Test_window_runtime", "test_CreateWindow end, msg: ${this.msg}")
                    })
                    .width(33.percent)
                Button("CreateWindow1")
                    .id("test_CreateWindow1")
                    .onClick ({ e
                        =>
                        Hilog.error(0, "Test_window_runtime", "test_CreateWindow1 start")
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
                        this.msg = "CreateWindow1 success"
                        Hilog.error(0, "Test_window_runtime", "test_CreateWindow1 end, msg: ${this.msg}")
                    })
                    .width(33.percent)
            }


            Row() {
                Button("getWindowAvoidArea")
                    .id("test_getWindowAvoidArea")
                    .onClick ({ e
                        =>
                        Hilog.error(0, "Test_window_runtime", "getWindowAvoidArea start")
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
                        this.msg = "getWindowAvoidArea success"
                        Hilog.error(0, "Test_window_runtime", "getWindowAvoidArea end, msg: ${this.msg}")
                    })
                    .width(33.percent)
                Button("windowMoveWindowTo")
                    .id("test_windowMoveWindowTo")
                    .onClick ({ e
                        =>
                        Hilog.error(0, "Test_window_runtime", "test_windowMoveWindowTo start")
                        let mainWindow = getMainWindow()
                        mainWindow.moveWindowTo(0, 0)
                        this.msg = "windowMoveWindowTo success"
                        Hilog.error(0, "Test_window_runtime", "test_windowMoveWindowTo end, msg: ${this.msg}")
                    })
                    .width(33.percent)
                Button("windowResize")
                    .id("test_windowResize")
                    .onClick ({ e
                        =>
                        Hilog.error(0, "Test_window_runtime", "test_windowResize start")
                        let mainWindow = getMainWindow()
                        let mainId = mainWindow
                            .getWindowProperties()
                            .id
                        let stageContext = getAbilityContext()
                        let conf3 = WindowConfiguration(name: "test7", windowType: WindowType.TypeDialog, ctx: stageContext,
                            displayId: 0, parentId: Int64(mainId))
                        let win3 = createWindow(conf3).resize(100, 100)
                        this.msg = "windowResize success"
                        Hilog.error(0, "Test_window_runtime", "test_windowResize end, msg: ${this.msg}")
                    })
                    .width(33.percent)
            }


            Row() {
                Button("windowMinimize")
                    .id("test_windowMinimize")
                    .onClick ({ e
                        =>
                        Hilog.error(0, "Test_window_runtime", "test_windowMinimize start")
                        let mainWindow = getMainWindow()
                        mainWindow.minimize()
                        this.msg = "windowMinimize success"
                        Hilog.error(0, "Test_window_runtime", "test_windowMinimize end, msg: ${this.msg}")
                    })
                    .width(33.percent)
                Button("struct")
                    .id("test_struct")
                    .onClick ({ e
                        =>
                        Hilog.error(0, "Test_window_runtime", "test_struct start")
                        let titleButtonRect = TitleButtonRect(right: 1, top: 1, width: 1, height: 1)
                        this.msg = "struct success"
                        Hilog.error(0, "Test_window_runtime", "test_struct end, msg: ${this.msg}")
                    })
                    .width(33.percent)
                Button("AvoidAreaStruct")
                    .id("test_AvoidAreaStruct")
                    .onClick ({ e
                        =>
                        Hilog.error(0, "Test_window_runtime", "test_AvoidAreaStruct start")
                        var avoidArea: AvoidArea = AvoidArea(visible: false, leftRect: WindowRect(left: 0, top: 0, width: 0,
                            height: 0), topRect: WindowRect(left: 0, top: 0, width: 0, height: 0),
                            rightRect: WindowRect(left: 0, top: 0, width: 0, height: 0),
                            bottomRect: WindowRect(left: 0, top: 0, width: 0, height: 0))
                        this.msg = "visible: ${avoidArea.visible}, leftRect: [${avoidArea.leftRect.left}, ${avoidArea.leftRect.top}, ${avoidArea.leftRect.width}, ${avoidArea.leftRect.height}]"
                        Hilog.error(0, "Test_window_runtime", "test_AvoidAreaStruct end, msg: ${this.msg}")
                    })
                    .width(33.percent)
            }


            Row() {
                Button("on_off")
                    .id("test_on_off")
                    .onClick ({ e
                        =>
                        Hilog.error(0, "Test_window_runtime", "test_on_off start")
                        let window = getMainWindow()
                        let callback = MyCallbackObject()
                        // test on twice
                        window.on(WindowCallbackType.KeyboardHeightChange, callback)
                        window.on(WindowCallbackType.KeyboardHeightChange, callback)
                        // test on invalid callbackType
                        // test off
                        window.off(WindowCallbackType.KeyboardHeightChange)
                        this.msg = "on_off success"
                        Hilog.error(0, "Test_window_runtime", "test_on_off end, msg: ${this.msg}")
                    })
                    .width(33.percent)
                Button("windowDestroyWindow")
                    .id("test_windowDestroyWindow")
                    .onClick ({ e
                        =>
                        Hilog.error(0, "Test_window_runtime", "test_windowDestroyWindow start")
                        let mainWindow = getMainWindow()
                        let mainId = mainWindow
                            .getWindowProperties()
                            .id
                        let stageContext = getAbilityContext()
                        let conf3 = WindowConfiguration(name: "test16", windowType: WindowType.TypeDialog, ctx: stageContext,
                            displayId: 0, parentId: Int64(mainId))
                        let win3 = createWindow(conf3)
                        win3.destroyWindow()
                        this.msg = "windowDestroyWindow success"
                        Hilog.error(0, "Test_window_runtime", "test_windowDestroyWindow end, msg: ${this.msg}")
                    })
                    .width(33.percent)
            }
        }.width(100.percent)
    }
}
