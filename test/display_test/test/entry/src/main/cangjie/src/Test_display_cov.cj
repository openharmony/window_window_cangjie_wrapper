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
import ohos.base.*
import ohos.display.*
import ohos.display.Rect as DisplayRect
internal import ohos.hilog.Hilog

@Test
class Test_display_cov {

    @TestCase
    @Tag[APILevel12, TestLevel0]
    func testDisplayCommonCov() {
        let rect = DisplayRect(left: 0, top: 0, width: 100, height: 200)
        try {
            Hilog.info(1, "CovTest", "Rect: ${rect.left}")
        } catch (e: Exception) {
            Hilog.info(1, "CovTest", "Rect: ${e.message}")
        }
        try {
            let rect0 = DisplayRect(left: 0, top: 0, width: 0, height: 0)
            Hilog.info(1, "CovTest", "Rect0: ${rect0.left}")
        } catch (e: Exception) {
            Hilog.info(1, "CovTest", "Rect0: ${e.message}")
        }
        try {
            let _ = WaterfallDisplayAreaRects(left: rect, top: rect, right: rect, bottom: rect)
        } catch (e: Exception) {
            Hilog.info(1, "CovTest", "WaterfallDisplayAreaRects: ${e.message}")
        }
        try {
            let wf = WaterfallDisplayAreaRects(left: rect, top: rect, right: rect, bottom: rect)
            let _ = CutoutInfo(boundingRects: [rect], waterfallDisplayAreaRects: wf)
        } catch (e: Exception) {
            Hilog.info(1, "CovTest", "CutoutInfo: ${e.message}")
        }
        try {
            let _ = FoldCreaseRegion(displayId: 0, creaseRects: [rect])
        } catch (e: Exception) {
            Hilog.info(1, "CovTest", "FoldCreaseRegion: ${e.message}")
        }
        try { let _ = getAllDisplays() } catch (e: Exception) { Hilog.info(1, "CovTest", "getAllDisplays: ${e.message}") }
        try {
            let displays = getAllDisplays()
            if (displays.size > 0) { let _ = displays[0].getCutoutInfo() }
        } catch (e: Exception) { Hilog.info(1, "CovTest", "getCutoutInfo: ${e.message}") }
        try { let _ = getCurrentFoldCreaseRegion() } catch (e: Exception) { Hilog.info(1, "CovTest", "getFoldCrease: ${e.message}") }
        try { let _ = isFoldable() } catch (e: Exception) { Hilog.info(1, "CovTest", "isFoldable: ${e.message}") }
        try { let _ = getFoldStatus() } catch (e: Exception) { Hilog.info(1, "CovTest", "getFoldStatus: ${e.message}") }
        try { let _ = getFoldDisplayMode() } catch (e: Exception) { Hilog.info(1, "CovTest", "getFoldDisplayMode: ${e.message}") }
    }
}
