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

import ohos.display.*
import ohos.display.Rect as DisplayRect
import std.unittest.testmacro.*
import std.runtime.*
import std.sync.*
import std.time.*
import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import ohos.base.*
internal import ohos.hilog.Hilog

@Test
class Test_display_runtime {
    override func afterAll(): Unit {
        GC()
        sleep(Duration.second)
    }

    @TestCase
    @Tag[APILevel12, TestLevel0]
    func test_GetDisplayInfo() {
        try {
            let displayClass = getDefaultDisplaySync()
            let cutoutInfo = displayClass.getCutoutInfo()
            let displayList = getAllDisplays()
            Hilog.error(0, "CangjieUI-test", "id:    " + displayClass
                .id
                .toString())
            Hilog.error(0, "CangjieUI-test", "name:  " + displayClass.name)
            Hilog.error(0, "CangjieUI-test", "alive: " + displayClass
                .alive
                .toString())
            Hilog.error(0, "CangjieUI-test", "refreshRate: " + displayClass
                .refreshRate
                .toString())
            Hilog.error(0, "CangjieUI-test", "rotation:    " + displayClass
                .rotation
                .toString())
            Hilog.error(0, "CangjieUI-test", "width:       " + displayClass
                .width
                .toString())
            Hilog.error(0, "CangjieUI-test", "height:      " + displayClass
                .height
                .toString())
            Hilog.error(0, "CangjieUI-test", "densityPixels: " + displayClass
                .densityPixels
                .toString())
            Hilog.error(0, "CangjieUI-test", "scaledDensity: " + displayClass
                .scaledDensity
                .toString())
            Hilog.error(0, "CangjieUI-test", "state: " + match (displayClass.state) {
                case DisplayState.StateUnknown => "unknow"
                case DisplayState.StateOff => "off"
                case DisplayState.StateOn => "on"
                case DisplayState.StateDoze => "doze"
                case DisplayState.StateDozeSuspend => "doze suspend"
                case DisplayState.StateVr => "vr"
                case DisplayState.StateOnSuspend => "on suspend"
                case _ => throw Exception("unsupported enum constructor")
            })
            Hilog.error(0, "CangjieUI-test", "orientation: " + match (displayClass.orientation) {
                case Orientation.Portrait => "PORTRAIT"
                case Orientation.Landscape => "LANDSCAPE"
                case Orientation.PortraitInverted => "PORTRAIT_INVERTED"
                case Orientation.LandscapeInverted => "LANDSCAPE_INVERTED"
                case _ => "unknow"
            })
            @Expect(displayList.size != 0)
            if (isFoldable()) {
                let status = getFoldStatus()
                let mode = getFoldDisplayMode()
            } else {
                let status = getFoldStatus()
                let mode = getFoldDisplayMode()
            }
            try {
                let region = getCurrentFoldCreaseRegion()
            } catch (e: Exception) {
                Hilog.error(0, "CangjieUI-test", "Not fold display.")
            }
        } catch (e: Exception) {
            Hilog.error(0, "CangjieUI-test", "Display info failed.")
            @Expect(false)
        }
        @Expect(true)
    }

    @TestCase
    @Tag[APILevel12, TestLevel0]
    func test_DisplayStruct() {
        try {
            let rectLeft = DisplayRect(left: 0, top: 0, width: 0, height: 0)
            let rectTop = DisplayRect(left: 0, top: 0, width: 0, height: 0)
            let rectRight = DisplayRect(left: 0, top: 0, width: 0, height: 0)
            let rectBottom = DisplayRect(left: 0, top: 0, width: 0, height: 0)
            let rectList = [rectLeft, rectTop, rectRight, rectBottom]
            let waterfallDisplayAreaRects = WaterfallDisplayAreaRects(left: rectLeft, top: rectTop, right: rectRight,
                bottom: rectBottom)
            let cutoutInfo = CutoutInfo(boundingRects: rectList, waterfallDisplayAreaRects: waterfallDisplayAreaRects)
            let foldCreaseRegion = FoldCreaseRegion(displayId: 0, creaseRects: rectList)
        } catch (e: Exception) {
            Hilog.error(0, "CangjieUI-test", "Display struct failed.")
            @Expect(false)
        }
        @Expect(true)
    }

    @TestCase
    @Tag[APILevel12, TestLevel0]
    func test_hasPrivateWindow() {
        try {
            let displayClass = getDefaultDisplaySync()
            let displayId = displayClass.id
        } catch (e: Exception) {
            Hilog.error(0, "CangjieUI-test", "test hasPrivateWindow failed.")
            @Expect(false)
        }
        @Expect(true)
    }

    @TestCase
    @Tag[APILevel12, TestLevel0]
    func test_getAllDisplayPhysicalResolution() {
        try {
            let foldDisplayMode = getFoldDisplayMode()
            Hilog.error(0, "CangjieUI-test", "FoldDisplayMode: " + match (foldDisplayMode) {
                case FoldDisplayMode.FoldDisplayModeUnknown => "FOLD_DISPLAY_MODE_UNKNOWN"
                case FoldDisplayMode.FoldDisplayModeFull => "FOLD_DISPLAY_MODE_FULL"
                case FoldDisplayMode.FoldDisplayModeMain => "FOLD_DISPLAY_MODE_MAIN"
                case FoldDisplayMode.FoldDisplayModeSub => "FOLD_DISPLAY_MODE_SUB"
                case FoldDisplayMode.FoldDisplayModeCoordination => "FOLD_DISPLAY_MODE_COORDINATION"
                case _ => throw Exception("unsupported enum constructor")
            })
        } catch (e: Exception) {
            Hilog.error(0, "CangjieUI-test", "test getAllDisplayPhysicalResolution failed.")
            @Expect(false)
        }
        @Expect(true)
    }
}
