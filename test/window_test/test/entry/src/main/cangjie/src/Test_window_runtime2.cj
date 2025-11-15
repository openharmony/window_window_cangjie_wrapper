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

@Test
class Test_window_runtime2 {
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
    func test_windowMinimize() {
        clickButton("test_windowMinimize")
        var prop2: String = getContentFromText("message")
        @Expect(prop2.contains("windowMinimize success"))
    }
}
