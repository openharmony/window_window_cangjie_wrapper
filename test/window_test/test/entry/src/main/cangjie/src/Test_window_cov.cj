/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

import std.unittest.testmacro.*
import std.unittest.*
import ohos.ui_test.*
import ohos.base.*
import ohos.business_exception.BusinessException
import ohos.arkui.state_management.AppStorage
import ohos.app.ability.ui_ability.UIAbilityContext
import ohos.callback_invoke.Callback1Argument
import ohos.window.{Size, TitleButtonRect, Configuration as WindowConfiguration, WindowType, WindowCallbackType, AvoidAreaType, getLastWindow, createWindow}

class KeyboardHeightCallback <: Callback1Argument<UInt32> {
    public init() {}
    public open func invoke(err: ?BusinessException, event: UInt32): Unit {
        Hilog.info(1, "CovTest", "keyboard height: ${event}")
    }
}

@Test
class Test_window_cov {
    prop driver: Driver {
        get() {
            OpenHarmonyTestRunner.driver
        }
    }

    private func getAbilityContext(): UIAbilityContext {
        AppStorage.get<UIAbilityContext>("abilityContext").getOrThrow()
    }


    @TestCase
    @Tag[APILevel16, TestLevel0]
    func testWindowCommonCov() {
        try {
            let _ = Size(width: 100, height: 200)
        } catch (e: Exception) {
            Hilog.info(1, "CovTest", "Size: ${e.message}")
        }
        try {
            let _ = Size(width: 0, height: 0)
        } catch (e: Exception) {
            Hilog.info(1, "CovTest", "Size0: ${e.message}")
        }
        try {
            let _ = TitleButtonRect(right: 10, top: 20, width: 30, height: 40)
        } catch (e: Exception) {
            Hilog.info(1, "CovTest", "TitleButtonRect: ${e.message}")
        }
        try {
            let _ = WindowConfiguration(name: "covWindow", windowType: WindowType.TypeApp, ctx: getAbilityContext(), displayId: 0)
        } catch (e: Exception) {
            Hilog.info(1, "CovTest", "Configuration: ${e.message}")
        }
    }


    @TestCase
    @Tag[APILevel16, TestLevel0]
    func testWindowCov() {
        try {
            let window = getLastWindow(getAbilityContext())
            try {
                window.on(WindowCallbackType.KeyboardHeightChange, KeyboardHeightCallback())
            } catch (e: Exception) {
                Hilog.info(1, "CovTest", "on keyboard: ${e.message}")
            }
            try {
                window.off(WindowCallbackType.WindowVisibilityChange)
            } catch (e: Exception) {
                Hilog.info(1, "CovTest", "off visibility: ${e.message}")
            }
        } catch (e: Exception) {
            Hilog.info(1, "CovTest", "getLastWindow: ${e.message}")
        }
        try {
            let config = WindowConfiguration(name: "covWin", windowType: WindowType.TypeApp, ctx: getAbilityContext(), displayId: 0)
            let _ = createWindow(config)
        } catch (e: Exception) {
            Hilog.info(1, "CovTest", "createWindow ok: ${e.message}")
        }
        try {
            let config2 = WindowConfiguration(name: "covWin", windowType: WindowType.TypeApp, ctx: getAbilityContext(), displayId: 0)
            let _ = createWindow(config2)
        } catch (e: Exception) {
            Hilog.info(1, "CovTest", "createWindow dup: ${e.message}")
        }
    }

    @TestCase
    @Tag[APILevel16, TestLevel0]
    func testWindowBranchCov() {
        try {
            let emptyConfig = WindowConfiguration(name: "", windowType: WindowType.TypeApp, ctx: getAbilityContext(), displayId: 0)
            let _ = createWindow(emptyConfig)
        } catch (e: Exception) {
            Hilog.info(1, "CovTest", "createWindow empty: ${e.message}")
        }
        try {
            let win = getLastWindow(getAbilityContext())
            let cb = KeyboardHeightCallback()
            try { win.on(WindowCallbackType.KeyboardHeightChange, cb) } catch (e: Exception) { Hilog.info(1, "CovTest", "on kb: ${e.message}") }
            try { win.on(WindowCallbackType.KeyboardHeightChange, cb) } catch (e: Exception) { Hilog.info(1, "CovTest", "on kb dup: ${e.message}") }
            try { win.off(WindowCallbackType.KeyboardHeightChange, cb) } catch (e: Exception) { Hilog.info(1, "CovTest", "off kb: ${e.message}") }
            try { win.off(WindowCallbackType.KeyboardHeightChange, cb) } catch (e: Exception) { Hilog.info(1, "CovTest", "off kb miss: ${e.message}") }
            try { win.off(WindowCallbackType.KeyboardHeightChange) } catch (e: Exception) { Hilog.info(1, "CovTest", "off kb nocb: ${e.message}") }
            try { let _ = win.getWindowProperties() } catch (e: Exception) { Hilog.info(1, "CovTest", "getWindowProperties: ${e.message}") }
            try { let _ = win.getWindowAvoidArea(AvoidAreaType.TypeSystem) } catch (e: Exception) { Hilog.info(1, "CovTest", "getWindowAvoidArea: ${e.message}") }
        } catch (e: Exception) {
            Hilog.info(1, "CovTest", "getLastWindow branch: ${e.message}")
        }
    }
}
