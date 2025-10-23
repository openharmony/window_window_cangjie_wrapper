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

// The Cangjie API is in Beta. For details on its capabilities and limitations, please refer to the README file.

package ohos.window

internal import ohos.ffi.*

foreign {
    func FfiOHOSBindWindowStage(handler: Int64): RetDataI64

    func FfiOHOSGetMainWindow(id: Int64): RetDataI64

    func FfiOHOSCreateSubWindow(id: Int64, name: CString): RetDataI64

    func FfiOHOSGetSubWindow(id: Int64): RetStruct

    func FfiOHOSLoadContent(id: Int64, path: CString): Int32

    func FfiOHOSLoadContentByName(id: Int64, name: CString): Int32

    func FfiOHOSDisableWindowDecor(id: Int64): Int32

    func FfiOHOSSetShowOnLockScreen(id: Int64, showOnLockScreen: Bool): Int32

    func FfiOHOSSetDefaultDensityEnabled(id: Int64, enabled: Bool): Int32

    func FfiOHOSStageOn(id: Int64, callbackId: Int64): Int32

    func FfiOHOSStageOff(id: Int64, callbackId: Int64): Int32

    func FfiOHOSCreateSubWindowWithOptionsStage(id: Int64, name: CString, title: CString, decorEnabled: Bool,
        isModal: Bool): RetDataI64
}

let stageRegisterMutex = Mutex()

/**
 * WindowStage.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public class WindowStage <: RemoteDataLite {
    let callbackMaps = HashMap<String, ArrayList<(CallbackObject, Int64)>>(
        [("windowStageEvent", ArrayList<(CallbackObject, Int64)>())])
    protected init(windowStageHandler: Int64) {
        let ret = unsafe { FfiOHOSBindWindowStage(windowStageHandler) }
        checkRet(ret.code, "[WindowStage] bind WindowStage: ")
        dataInit(ret.data)
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Obtains the main window of this window stage.
     *
     * @returns { Window } the main window.
     * @throws { BusinessException } 1300002 - This window state is abnormal.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func getMainWindow(): Window {
        unsafe {
            let ret = FfiOHOSGetMainWindow(getID())
            checkRet(ret.code, "[WindowStage] get mainwindow: ")
            getOrCreate(Window.instanceMap, ret.data, {id: Int64 => Window(id)})
        }
    }

    /**
     * Creates a child window for this window stage.
     *
     * @param { String } name - Name of the child window.
     * @returns { Window } the child window.
     * @throws { BusinessException } 1300002 - This window state is abnormal.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func createSubWindow(name: String): Window {
        unsafe {
            var ret: ?RetDataI64 = None
            try (cname = LibC.mallocCString(name).asResource()) {
                ret = FfiOHOSCreateSubWindow(getID(), cname.value)
            }
            checkRet(ret.getOrThrow().code, "[WindowStage] create subwindow: ")
            getOrCreate(Window.instanceMap, ret.getOrThrow().data, {id: Int64 => Window(id)})
        }
    }

    /**
     * Obtains all the child windows of this window stage.
     *
     * @returns { Array<Window> } all the child windows.
     * @throws { BusinessException } 1300002 - This window state is abnormal.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func getSubWindow(): Array<Window> {
        unsafe {
            var ret = FfiOHOSGetSubWindow(getID())
            checkRet(ret.code, "[WindowStage] get subWindow: ")
            let dataPtr = CPointer<Int64>(ret.data)
            let idArray = Array<Int64>(ret.len, {i => dataPtr.read(i)})
            LibC.free<Int64>(dataPtr)
            let result = Array<Window>(ret.len,
                {i => getOrCreate(Window.instanceMap, idArray[i], {id: Int64 => Window(id)})})
            return result
        }
    }

    /**
     * Loads content from a page to this window. You are advised to call this API during UIAbility startup.
     * If called multiple times, this API will destroy the existing page content (UIContent) before loading the new content. Exercise caution when using it.
     *
     * @param { String } path - Path of the page to which the content will be loaded.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func loadContent(path: String): Unit {
        unsafe {
            try (cpath = LibC.mallocCString(path).asResource()) {
                FfiOHOSLoadContent(getID(), cpath.value)
            }
        }
    }
}
