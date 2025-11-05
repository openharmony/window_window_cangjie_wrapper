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

package ohos.display

import ohos.labels.APILevel
import ohos.business_exception.BusinessException
import ohos.ffi.{Callback1Param, RemoteDataLite, releaseFFIData, getOrCreate}
import ohos.callback_invoke.{CallbackObject, Callback1Argument}
import std.sync.Mutex
import std.collection.{HashMap, ArrayList}

foreign {
    func FfiOHOSGetDefaultDisplaySync(): RetStruct

    func FfiOHOSGetAllDisplays(): RetStruct

    func FfiOHOSIsFoldable(): Bool

    func FfiOHOSGetFoldStatus(): UInt32

    func FfiOHOSGetFoldDisplayMode(): UInt32

    func FfiOHOSGetCurrentFoldCreaseRegion(): RetStruct

    func FfiOHOSIsCaptured(): Bool

    func FfiOHOSGetAllDisplayPhysicalResolution(): RetStruct

    func FfiOHOSUnRegisterAllDisplayManagerCallback(callbackType: CString): Int32

    func FfiOHOSRegisterDisplayManagerCallback(callbackType: CString, callbackId: Int64): Int32

    func FfiOHOSUnRegisterDisplayManagerCallback(callbackType: CString, callbackId: Int64): Int32

    func FfiOHOSDisplayGetId(id: Int64): UInt32

    func FfiOHOSGetDisplayName(id: Int64): CString

    func FfiOHOSDisplayGetAlive(id: Int64): Bool

    func FfiOHOSDisplayGetState(id: Int64): UInt32

    func FfiOHOSDisplayGetRefreshRate(id: Int64): UInt32

    func FfiOHOSDisplayGetRotation(id: Int64): UInt32

    func FfiOHOSDisplayGetOrientation(id: Int64): UInt32

    func FfiOHOSDisplayGetWidth(id: Int64): Int32

    func FfiOHOSDisplayGetHeight(id: Int64): Int32

    func FfiOHOSDisplayGetDensityDPI(id: Int64): Float32

    func FfiOHOSDisplayGetVirtualPixelRatio(id: Int64): Float32

    func FfiOHOSDisplayGetXDPI(id: Int64): Float32

    func FfiOHOSDisplayGetYDPI(id: Int64): Float32

    func FfiOHOSDisplayGetColorSpaces(id: Int64): RetStruct

    func FfiOHOSDisplayGetHdrFormats(id: Int64): RetStruct

    func FfiOHOSDisplayGetAvailableWidth(id: Int64): UInt32

    func FfiOHOSDisplayGetAvailableHeight(id: Int64): UInt32

    func FfiOHOSDisplayGetCutoutInfo(id: Int64): RetStruct

    func FfiOHOSDisplayGetAvailableArea(id: Int64): RetStruct

    func FfiOHOSDisplayUnRegisterAllDisplayManagerCallback(callbackType: CString, id: Int64): Int32

    func FfiOHOSDisplayRegisterDisplayManagerCallback(callbackType: CString, id: Int64, callbackId: Int64): Int32

    func FfiOHOSDisplayUnRegisterDisplayManagerCallback(callbackType: CString, id: Int64, callbackId: Int64): Int32
}

const EXCEPTION_PARAMCHECK: Int32 = 401
let REGISTER_MUTEX = Mutex()
let CALLBACK_MAP = HashMap<String, ArrayList<(CallbackObject, Int64)>>(
    [
        (ListenerTypeAdd.getValue(), ArrayList<(CallbackObject, Int64)>()),
        (ListenerTypeRemove.getValue(), ArrayList<(CallbackObject, Int64)>()),
        (ListenerTypeChange.getValue(), ArrayList<(CallbackObject, Int64)>()),
        (ListenerTypeFoldStatusChange.getValue(), ArrayList<(CallbackObject, Int64)>()),
        (ListenerTypeFoldAngleChange.getValue(), ArrayList<(CallbackObject, Int64)>()),
        (ListenerTypeCaptureStatusChange.getValue(), ArrayList<(CallbackObject, Int64)>()),
        (ListenerTypeFoldDisplayModeChange.getValue(), ArrayList<(CallbackObject, Int64)>()),
        (ListenerTypeAvailableAreaChange.getValue(), ArrayList<(CallbackObject, Int64)>())
    ]
)

func findCallbackObject(list: ArrayList<(CallbackObject, Int64)>, callback: CallbackObject): Int64 {
    for (idx in 0..list.size) {
        if (refEq(callback, list[idx][0])) {
            return idx
        }
    }
    return -1
}

/**
 * Obtain the default display.
 *
 * @returns { Display } the result of display
 * @throws { BusinessException } 1400001 - Invalid display or screen.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public func getDefaultDisplaySync(): Display {
    unsafe {
        let ret = FfiOHOSGetDefaultDisplaySync()
        if (ret.code != 0) {
            DISPLAY_LOG.error("[display] ERROR: ${ret.code} Failed to get default display.")
            throw BusinessException(ret.code, "ERROR: Failed to get default display.")
        }
        let dataPtr = CPointer<Int64>(ret.data)
        let retVal = dataPtr.read()
        LibC.free<Int64>(dataPtr)
        return getOrCreate(Display.INSTANCE_MAP, retVal, {id: Int64 => Display(id)})
    }
}

/**
 * Obtain all displays.
 *
 * @returns { Array<Display> } the result of all displays
 * @throws { BusinessException } 1400001 - Invalid display or screen.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public func getAllDisplays(): Array<Display> {
    unsafe {
        let ret = FfiOHOSGetAllDisplays()
        if (ret.code != 0) {
            DISPLAY_LOG.error("[display] ERROR: ${ret.code} Failed to get all displays.")
            throw BusinessException(ret.code, "ERROR: Failed to get all displays.")
        }
        let dataPtr = CPointer<Int64>(ret.data)
        let idArray = Array<Int64>(ret.len, {i => dataPtr.read(i)})
        LibC.free<Int64>(dataPtr)
        let result = Array<Display>(ret.len,
            {i => getOrCreate(Display.INSTANCE_MAP, idArray[i], {id: Int64 => Display(id)})})
        return result
    }
}

/**
 * Check whether the device is foldable.
 *
 * @returns { Bool } true means the device is foldable.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Window.SessionManager"
]
public func isFoldable(): Bool {
    unsafe { FfiOHOSIsFoldable() }
}

/**
 * Get the current fold status of the foldable device.
 *
 * @returns { FoldStatus } fold status of device.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Window.SessionManager"
]
public func getFoldStatus(): FoldStatus {
    unsafe {
        let ret = FfiOHOSGetFoldStatus()
        return FoldStatus.parse(ret)
    }
}

/**
 * Get the display mode of the foldable device.
 *
 * @returns { FoldDisplayMode } display mode of the foldable device.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Window.SessionManager"
]
public func getFoldDisplayMode(): FoldDisplayMode {
    unsafe {
        let ret = FfiOHOSGetFoldDisplayMode()
        return FoldDisplayMode.parse(ret)
    }
}

/**
 * Get the fold crease region in the current display mode.
 *
 * @returns { FoldCreaseRegion } fold crease region in the current display mode.
 * @throws { BusinessException } 1400003 - This display manager service works abnormally.
 * @throws { BusinessException } 100001 - Internal error: Failed to create target pointer type.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Window.SessionManager"
]
public func getCurrentFoldCreaseRegion(): FoldCreaseRegion {
    let retData = unsafe {
        FfiOHOSGetCurrentFoldCreaseRegion()
    }
    if (retData.code != 0) {
        DISPLAY_LOG.error("[Display] ERROR: ${retData.code} Failed to get current fold crease region.")
        throw BusinessException(retData.code, "ERROR: Failed to get current fold crease region.")
    }
    let ptr = unsafe { CPointer<CFoldCreaseRegion>(retData.data) }
    if (ptr.isNull()) {
        unsafe { LibC.free(retData.data) }
        throw BusinessException(100001, "Internal error: Failed to create target pointer type")
    }
    let foldCreaseRegion = unsafe { ptr.read() }
    let ret = FoldCreaseRegion(foldCreaseRegion)
    unsafe {
        LibC.free<CRect>(foldCreaseRegion.creaseRects)
        LibC.free<CFoldCreaseRegion>(ptr)
    }
    return ret
}

/**
 * Unregister the callback for given event type.
 *
 * @param { ListenerType } listenerType - Type of listening event
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Window.SessionManager"
]
public func off(listenerType: ListenerType): Unit {
    offAllCallback(listenerType.getValue())
}

func offAllCallback(callbackType: String): Unit {
    synchronized(REGISTER_MUTEX) {
        var v = CALLBACK_MAP.entryView(callbackType)
        if (v.value.isNone()) {
            DISPLAY_LOG.error("[display] ERROR: Failed to unregister callback with type ${callbackType}")
            return
        }
        unsafe {
            v.value.getOrThrow().clear()
            try (callbackCType = LibC.mallocCString(callbackType).asResource()) {
                let ret = FfiOHOSUnRegisterAllDisplayManagerCallback(callbackCType.value)
                if (ret != 0) {
                    DISPLAY_LOG.error("[display] ERROR: ${ret} Failed to unregister callback with type ${callbackType}")
                    throw BusinessException(ret, "ERROR: Failed to unregister callback with type ${callbackType}")
                }
            }
        }
    }
}

/**
 * Register the callback for fold status changes.
 *
 * @param { ListenerType } listenerType - the event of fold status changes.
 * @param { Callback1Argument<FoldStatus> } callback - Callback used to return the current fold status of device.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 1400003 - This display manager service works abnormally.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Window.SessionManager"
]
public func on(listenerType: ListenerType, callback: Callback1Argument<FoldStatus>): Unit {
    match (listenerType) {
        case ListenerTypeFoldStatusChange => onFoldStatusChange(listenerType.getValue(), callback)
        case _ => throw BusinessException(EXCEPTION_PARAMCHECK,
            "Parameter error: ${listenerType.getValue()} is not supported.")
    }
}

func onFoldStatusChange(callbackType: String, callback: Callback1Argument<FoldStatus>): Unit {
    synchronized(REGISTER_MUTEX) {
        var v = CALLBACK_MAP.entryView(callbackType)
        if (v.value.isNone()) {
            DISPLAY_LOG.error("[display] ERROR: Failed to register callback with type ${callbackType}")
            return
        }
        if (findCallbackObject(v.value.getOrThrow(), callback) >= 0) {
            DISPLAY_LOG.info("[Display] INFO: The callback obj already registered!")
            return
        }
        let wrapper = {
            value: CPointer<Unit> =>
            let foldStatus = unsafe { CPointer<UInt32>(value).read() }
            callback.invoke(None, FoldStatus.parse(foldStatus))
        }
        let registerCall = Callback1Param<CPointer<Unit>, Unit>(wrapper)
        unsafe {
            try (callbackCType = LibC.mallocCString(callbackType).asResource()) {
                let ret = FfiOHOSRegisterDisplayManagerCallback(callbackCType.value, registerCall.getID())
                if (ret != 0) {
                    DISPLAY_LOG.error("[display] ERROR: ${ret} Failed to register callback with type ${callbackType}")
                    throw BusinessException(ret, "ERROR: Failed to register callback with type ${callbackType}")
                }
            }
        }
        v.value.getOrThrow().add((callback, registerCall.getID()))
    }
}

/**
 * Unregister the callback for fold status changes.
 *
 * @param { ListenerType } listenerType - the event of fold status change.
 * @param { Callback1Argument<FoldStatus> } callback - Callback used to return the current fold status of device.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 1400003 - This display manager service works abnormally.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Window.SessionManager"
]
public func off(listenerType: ListenerType, callback: Callback1Argument<FoldStatus>): Unit {
    match (listenerType) {
        case ListenerTypeFoldStatusChange => offFoldStatusChange(listenerType.getValue(), callback)
        case _ => throw BusinessException(EXCEPTION_PARAMCHECK,
            "Parameter error: ${listenerType.getValue()} is not supported.")
    }
}

func offFoldStatusChange(callbackType: String, callback: Callback1Argument<FoldStatus>): Unit {
    synchronized(REGISTER_MUTEX) {
        var v = CALLBACK_MAP.entryView(callbackType)
        if (v.value.isNone()) {
            DISPLAY_LOG.error("[display] ERROR: Failed to unregister callback with type ${callbackType}")
            return
        }
        let idx = findCallbackObject(v.value.getOrThrow(), callback)
        if (idx == -1) {
            DISPLAY_LOG.info("[Display] INFO: The callback obj is not registered!")
            return
        }
        unsafe {
            let callbackId = v.value.getOrThrow()[idx][1]
            try (callbackCType = LibC.mallocCString(callbackType).asResource()) {
                let ret = FfiOHOSUnRegisterDisplayManagerCallback(callbackCType.value, callbackId)
                if (ret != 0) {
                    DISPLAY_LOG.error("[display] ERROR: ${ret} Failed to unregister callback with type ${callbackType}")
                    throw BusinessException(ret, "ERROR: Failed to unregister callback with type ${callbackType}")
                }
            }
            v.value.getOrThrow().remove(at: idx)
        }
    }
}

/**
 * Register the callback for fold display mode changes.
 *
 * @param { ListenerType } listenerType - the event of fold display mode changes.
 * @param { Callback1Argument<FoldDisplayMode> } callback - Callback used to return the current fold display mode.
 * @throws { BusinessException } 1400003 - This display manager service works abnormally.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Window.SessionManager"
]
public func on(listenerType: ListenerType, callback: Callback1Argument<FoldDisplayMode>): Unit {
    match (listenerType) {
        case ListenerTypeFoldDisplayModeChange => onFoldDisplayModeChange(listenerType.getValue(), callback)
        case _ => throw BusinessException(EXCEPTION_PARAMCHECK,
            "Parameter error: ${listenerType.getValue()} is not supported.")
    }
}

func onFoldDisplayModeChange(callbackType: String, callback: Callback1Argument<FoldDisplayMode>): Unit {
    synchronized(REGISTER_MUTEX) {
        var v = CALLBACK_MAP.entryView(callbackType)
        if (v.value.isNone()) {
            DISPLAY_LOG.error("[display] ERROR: Failed to register callback with type ${callbackType}")
            return
        }
        if (findCallbackObject(v.value.getOrThrow(), callback) >= 0) {
            DISPLAY_LOG.info("[Display] INFO: The callback obj already registered!")
            return
        }
        unsafe {
            let wrapper = {
                value: CPointer<Unit> =>
                let argv = CPointer<UInt32>(value).read()
                callback.invoke(None, FoldDisplayMode.parse(argv))
            }
            let registerCall = Callback1Param<CPointer<Unit>, Unit>(wrapper)
            try (callbackCType = LibC.mallocCString(callbackType).asResource()) {
                let ret = FfiOHOSRegisterDisplayManagerCallback(callbackCType.value, registerCall.getID())
                if (ret != 0) {
                    DISPLAY_LOG.error("[display] ERROR: ${ret} Failed to register callback with type ${callbackType}")
                    throw BusinessException(ret, "ERROR: Failed to register callback with type ${callbackType}")
                }
            }
            v.value.getOrThrow().add((callback, registerCall.getID()))
        }
    }
}

/**
 * Unregister the callback for fold display mode changes.
 *
 * @param { ListenerType } listenerType - the event of fold display mode changes.
 * @param { Callback1Argument<FoldDisplayMode> } callback - Callback used to return the current fold display mode.
 * @throws { BusinessException } 1400003 - This display manager service works abnormally.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Window.SessionManager"
]
public func off(listenerType: ListenerType, callback: Callback1Argument<FoldDisplayMode>): Unit {
    match (listenerType) {
        case ListenerTypeFoldDisplayModeChange => offFoldDisplayModeChange(listenerType.getValue(), callback)
        case _ => throw BusinessException(EXCEPTION_PARAMCHECK,
            "Parameter error: ${listenerType.getValue()} is not supported.")
    }
}

func offFoldDisplayModeChange(callbackType: String, callback: Callback1Argument<FoldDisplayMode>): Unit {
    synchronized(REGISTER_MUTEX) {
        var v = CALLBACK_MAP.entryView(callbackType)
        if (v.value.isNone()) {
            DISPLAY_LOG.error("[display] ERROR: Failed to unregister callback with type ${callbackType}")
            return
        }
        let idx = findCallbackObject(v.value.getOrThrow(), callback)
        if (idx == -1) {
            DISPLAY_LOG.info("[Display] INFO: The callback obj is not registered!")
            return
        }
        unsafe {
            let callbackId = v.value.getOrThrow()[idx][1]
            try (callbackCType = LibC.mallocCString(callbackType).asResource()) {
                let ret = FfiOHOSUnRegisterDisplayManagerCallback(callbackCType.value, callbackId)
                if (ret != 0) {
                    DISPLAY_LOG.error("[display] ERROR: ${ret} Failed to unregister callback with type ${callbackType}")
                    throw BusinessException(ret, "ERROR: Failed to unregister callback with type ${callbackType}")
                }
            }
            v.value.getOrThrow().remove(at: idx)
        }
    }
}

/**
 * Define properties of the display. They cannot be updated automatically.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public class Display <: RemoteDataLite {
    static let INSTANCE_MAP = HashMap<Int64, Display>()
    static let REGISTER_MUTEX = Mutex()

    /**
     * Display ID.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public prop id: Int64 {
        get() {
            unsafe { FfiOHOSDisplayGetId(getID()) }
        }
    }

    /**
     * Display name.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public prop name: String {
        get() {
            let retData = unsafe { FfiOHOSGetDisplayName(getID()) }
            let ret = retData.toString()
            DISPLAY_LOG.info("[Display] name: " + ret)
            unsafe { LibC.free(retData) }
            return ret
        }
    }

    /**
     * The display is alive.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public prop alive: Bool {
        get() {
            unsafe { FfiOHOSDisplayGetAlive(getID()) }
        }
    }

    /**
     * The state of display.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public prop state: DisplayState {
        get() {
            let retData = unsafe { FfiOHOSDisplayGetState(getID()) }
            let ret = DisplayState.parse(retData)
            return ret
        }
    }

    /**
     * Refresh rate, in Hz.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public prop refreshRate: UInt32 {
        get() {
            unsafe { FfiOHOSDisplayGetRefreshRate(getID()) }
        }
    }

    /**
     * An enumeration value for rotation degrees of the display.
     * The value 0 indicates that the screen of the display rotates clockwise by 0°.
     * The value 1 indicates that the screen of the display rotates clockwise by 90°.
     * The value 2 indicates that the screen of the display rotates clockwise by 180°.
     * The value 3 indicates that the screen of the display rotates clockwise by 270°.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public prop rotation: UInt32 {
        get() {
            unsafe { FfiOHOSDisplayGetRotation(getID()) }
        }
    }

    /**
     * Display orientation.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public prop orientation: Orientation {
        get() {
            let retData = unsafe { FfiOHOSDisplayGetOrientation(getID()) }
            let ret = Orientation.parse(retData)
            return ret
        }
    }

    /**
     * Display width, in pixels.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public prop width: Int64 {
        get() {
            unsafe { FfiOHOSDisplayGetWidth(getID()) }
        }
    }

    /**
     * Display height, in pixels.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public prop height: Int64 {
        get() {
            unsafe { FfiOHOSDisplayGetHeight(getID()) }
        }
    }

    /**
     * Display density, in pixels. which is the scaling coefficient between physical pixels and logical pixels. The value for a low-resolution display is 1.0.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public prop densityDpi: Float64 {
        get() {
            unsafe { FfiOHOSDisplayGetDensityDPI(getID()) }
        }
    }

    /**
     * Display resolution, that is, the number of pixels per inch.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public prop densityPixels: Float64 {
        get() {
            unsafe { FfiOHOSDisplayGetVirtualPixelRatio(getID()) }
        }
    }

    /**
     * Text scale density of the display.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public prop scaledDensity: Float64 {
        get() {
            unsafe { FfiOHOSDisplayGetVirtualPixelRatio(getID()) }
        }
    }

    /**
     * DPI on the x-axis.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public prop xDpi: Float64 {
        get() {
            unsafe { FfiOHOSDisplayGetXDPI(getID()) }
        }
    }

    /**
     * DPI on the y-axis.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public prop yDpi: Float64 {
        get() {
            unsafe { FfiOHOSDisplayGetYDPI(getID()) }
        }
    }

    init(id: Int64) {
        super(id)
        DISPLAY_LOG.info("[Display] construct success")
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Obtain the cutout info of the display.
     *
     * @returns { CutoutInfo } The cutout info of the display.
     * @throws { BusinessException } 1400001 - Invalid display or screen.
     * @throws { BusinessException } 1400003 - This display manager service works abnormally.
     * @throws { BusinessException } 100001 - Internal error: Failed to create target pointer type.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func getCutoutInfo(): CutoutInfo {
        let retData = unsafe {
            FfiOHOSDisplayGetCutoutInfo(getID())
        }
        if (retData.code != 0) {
            DISPLAY_LOG.error("[Display] ERROR: ${retData.code} Failed to get cutout info.")
            throw BusinessException(retData.code, "ERROR: Failed to get cutout info.")
        }
        let ptr = unsafe { CPointer<CCutoutInfo>(retData.data) }
        if (ptr.isNull()) {
            unsafe { LibC.free(retData.data) }
            throw BusinessException(100001, "Internal error: Failed to create target pointer type")
        }
        let cutoutInfo = unsafe { ptr.read() }
        let ret = CutoutInfo(cutoutInfo)
        unsafe {
            LibC.free<CRect>(cutoutInfo.boundingRects)
            LibC.free<CCutoutInfo>(ptr)
        }
        return ret
    }
}
