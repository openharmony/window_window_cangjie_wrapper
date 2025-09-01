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

internal import kit.ArkUI.{isFoldable, getFoldStatus, getFoldDisplayMode, getCurrentFoldCreaseRegion, FoldCreaseRegion, 
    getDefaultDisplaySync, getAllDisplays, DisplayState, DisplayOrientation as orientation, DisplayRect, 
    WaterfallDisplayAreaRects, CutoutInfo, setFoldDisplayMode, hasPrivateWindow, getAllDisplayPhysicalResolution, 
    DisplayPhysicalResolution, isCaptured, FoldDisplayMode}
import std.unittest.testmacro.*
import std.runtime.*
import std.sync.*
import std.time.*
import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import ohos.base.*

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
            logger.info("id:    " + displayClass.id.toString())
            logger.info("name:  " + displayClass.name)
            logger.info("alive: " + displayClass.alive.toString())
            logger.info("refreshRate: " + displayClass.refreshRate.toString())
            logger.info("rotation:    " + displayClass.rotation.toString())
            logger.info("width:       " + displayClass.width.toString())
            logger.info("height:      " + displayClass.height.toString())
            logger.info("densityDPI:  " + displayClass.densityDPI.toString())
            logger.info("densityPixels: " + displayClass.densityPixels.toString())
            logger.info("scaledDensity: " + displayClass.scaledDensity.toString())
            logger.info("xDPI: " + displayClass.xDPI.toString())
            logger.info("yDPI: " + displayClass.yDPI.toString())
            logger.info(
                "state: " + match (displayClass.state) {
                    case DisplayState.STATE_UNKNOWN => "unknow"
                    case DisplayState.STATE_OFF => "off"
                    case DisplayState.STATE_ON => "on"
                    case DisplayState.STATE_DOZE => "doze"
                    case DisplayState.STATE_DOZE_SUSPEND => "doze suspend"
                    case DisplayState.STATE_VR => "vr"
                    case DisplayState.STATE_ON_SUSPEND => "on suspend"
                    case _ => throw Exception("unsupported enum constructor")
                })
            logger.info(
                "orientation: " + match (displayClass.orientation) {
                    case orientation.PORTRAIT => "PORTRAIT"
                    case orientation.LANDSCAPE => "LANDSCAPE"
                    case orientation.PORTRAIT_INVERTED => "PORTRAIT_INVERTED"
                    case orientation.LANDSCAPE_INVERTED => "LANDSCAPE_INVERTED"
                    case _ => "unknow"
                })
            @Expect(displayList.size != 0)
            if (isFoldable()) {
                let status = getFoldStatus()
                let mode = getFoldDisplayMode()
                setFoldDisplayMode(mode)
            } else {
                let status = getFoldStatus()
                let mode = getFoldDisplayMode()
                setFoldDisplayMode(mode)
            }
            try {
                let region = getCurrentFoldCreaseRegion()
            } catch (e: Exception) {
                logger.error("Not fold display.")
            }
        } catch (e: Exception) {
            logger.error("Display info failed.")
            @Expect(false)
        }
        @Expect(true)
    }

    @TestCase
    @Tag[APILevel12, TestLevel0]
    func test_DisplayStruct() {
        try {
            let rectLeft = DisplayRect(0, 0, 0, 0)
            let rectTop = DisplayRect(0, 0, 0, 0)
            let rectRight = DisplayRect(0, 0, 0, 0)
            let rectBottom = DisplayRect(0, 0, 0, 0)
            let rectList = [rectLeft, rectTop, rectRight, rectBottom]
            let waterfallDisplayAreaRects = WaterfallDisplayAreaRects(rectLeft, rectTop, rectRight, rectBottom)
            let cutoutInfo = CutoutInfo(rectList, waterfallDisplayAreaRects)
            let foldCreaseRegion = FoldCreaseRegion(0, rectList)
            let displayPhysicalResolution: DisplayPhysicalResolution = DisplayPhysicalResolution(
                FOLD_DISPLAY_MODE_UNKNOWN, 0, 0)
        } catch (e: Exception) {
            logger.error("Display struct failed.")
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
            let ifHasPrivateWindow = hasPrivateWindow(displayId)

            //Enter error handling
            let ifHasPrivateWindow_error = hasPrivateWindow(1)
        } catch (e: Exception) {
            logger.error("test hasPrivateWindow failed.")
            @Expect(false)
        }
        @Expect(true)
    }

    @TestCase
    @Tag[APILevel12, TestLevel0]
    func test_getAllDisplayPhysicalResolution() {
        try {
            let displayPhysicalResolutions = getAllDisplayPhysicalResolution()
            for (idx in 0..displayPhysicalResolutions.size) {
                logger.info("Display id: [${idx}]")
                logger.info(
                    "[${idx}] FoldDisplayMode: " + match (displayPhysicalResolutions[idx].foldDisplayMode) {
                        case FoldDisplayMode.FOLD_DISPLAY_MODE_UNKNOWN => "FOLD_DISPLAY_MODE_UNKNOWN"
                        case FoldDisplayMode.FOLD_DISPLAY_MODE_FULL => "FOLD_DISPLAY_MODE_FULL"
                        case FoldDisplayMode.FOLD_DISPLAY_MODE_MAIN => "FOLD_DISPLAY_MODE_MAIN"
                        case FoldDisplayMode.FOLD_DISPLAY_MODE_SUB => "FOLD_DISPLAY_MODE_SUB"
                        case FoldDisplayMode.FOLD_DISPLAY_MODE_COORDINATION => "FOLD_DISPLAY_MODE_COORDINATION"
                        case _ => throw Exception("unsupported enum constructor")
                    })
                logger.info("[${idx}] physicalWidth: ${displayPhysicalResolutions[idx].physicalWidth}")
                logger.info("[${idx}] physicalHeight: ${displayPhysicalResolutions[idx].physicalHeight}")
            }
        } catch (e: Exception) {
            logger.error("test getAllDisplayPhysicalResolution failed.")
            @Expect(false)
        }
        @Expect(true)
    }

    @TestCase
    @Tag[APILevel12, TestLevel0]
    func test_isCaptured() {
        let captureState = isCaptured()
        // true表示设备有截屏、投屏、录屏，否则返回false
        @Expect(captureState, false)
    }

}
