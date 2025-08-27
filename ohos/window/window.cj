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

package ohos.window

internal import std.collection.*
internal import std.sync.*
import ohos.app.ability.BaseContext
internal import ohos.ffi.*
internal import ohos.multimedia.image.*
internal import ohos.callback_invoke.*
internal import ohos.business_exception.*

type StageContext = CPointer<Unit>

foreign {
    func FfiOHOSCreateWindow(name: CString, windowType: UInt32, ctx: StageContext, displayId: Int64, parentId: Int64): RetDataI64

    func FFiOHOSWindowFindWindow(name: CString): RetDataI64

    func FfiOHOSGetLastWindow(ctx: StageContext): RetDataI64

    func FfiOHOSShiftAppWindowFocus(sourceWindowId: Int32, targetWindowId: Int32): Int32

    func FfiOHOSWindowShowWindow(id: Int64): Int32

    func FfiOHOSWindowDestroyWindow(id: Int64): Int32

    func FfiOHOSWindowMoveWindowTo(id: Int64, x: Int32, y: Int32): Int32

    func FfiOHOSWindowResize(id: Int64, width: UInt32, height: UInt32): Int32

    func FfiOHOSWindowSetWindowLayoutFullScreen(id: Int64, isLayoutFullScreen: Bool): Int32

    func FfiOHOSWindowIsWindowSupportWideGamut(id: Int64, errCode: CPointer<Int32>): Bool

    func FfiOHOSWindowGetWindowProperties(id: Int64, errCode: CPointer<Int32>): CWindowProperties

    func FfiOHOSSetWindowBackgroundColor(id: Int64, color: CString): Int32

    func FfiOHOSWindowSetWindowBrightness(id: Int64, brightness: Float32): Int32

    func FfiOHOSWindowSetWindowFocusable(id: Int64, focusable: Bool): Int32

    func FfiOHOSWindowSetWindowKeepScreenOn(id: Int64, keepScreenOn: Bool): Int32

    func FfiOHOSWindowSetWindowPrivacyMode(id: Int64, isPrivacyMode: Bool): Int32

    func FfiOHOSWindowSetWindowTouchable(id: Int64, touchable: Bool): Int32

    func FfiOHOSWindowIsWindowShowing(id: Int64, errCode: CPointer<Int32>): Bool

    func FFiOHOSWindowSetPreferredOrientation(id: Int64, orientation: UInt32): Int32

    func FFiOHOSWindowGetWindowAvoidArea(id: Int64, areaType: UInt32, retPtr: CPointer<CAvoidArea>): Int32

    func FFiOHOSWindowSetAspectRatio(id: Int64, ratio: Float64): Int32

    func FFiOHOSWindowResetAspectRatio(id: Int64): Int32

    func FFiOHOSWindowMinimize(id: Int64): Int32

    func FFiOHOSWindowSetWindowColorSpace(id: Int64, colorSpace: UInt32): Int32

    func FFiOHOSWindowSetResizeByDragEnabled(id: Int64, enable: Bool): Int32

    func FFiOHOSWindowGetWindowColorSpace(id: Int64, errCode: CPointer<Int32>): UInt32

    func FFiOHOSWindowSnapshot(id: Int64, errCode: CPointer<Int32>): Int64

    func FFiOHOSWindowSetWindowSystemBarEnable(id: Int64, arr: CArrString): Int32

    func FFiOHOSWindowSetWindowSystemBarProperties(id: Int64, properties: CJBarProperties): Int32

    func FfiOHOSOnKeyboardHeightChange(id: Int64, callbackId: Int64): Int32

    func FfiOHOSOffKeyboardHeightChange(id: Int64): Int32

    func FfiOHOSIsFocused(id: Int64, errCode: CPointer<Int32>): Bool

    func FfiOHOSSetWindowLimits(id: Int64, windowlimits: CWindowLimits, retPtr: CPointer<CWindowLimits>): Int32

    func FfiOHOSGetWindowLimits(id: Int64, retPtr: CPointer<CWindowLimits>): Int32

    func FfiOHOSGetImmersiveModeEnabledState(id: Int64, errCode: CPointer<Int32>): Bool

    func FfiOHOSSetImmersiveModeEnabledState(id: Int64, enabled: Bool): Int32

    func FfiOHOSKeepKeyboardOnFocus(id: Int64, keepKeyboardFlag: Bool): Int32

    func FfiOHOSGetWindowDecorHeight(id: Int64, height: CPointer<Int32>): Int32

    func FfiOHOSSetWindowDecorHeight(id: Int64, height: Int32): Int32

    func FfiOHOSRecover(id: Int64): Int32

    func FfiOHOSSetWindowDecorVisible(id: Int64, isVisible: Bool): Int32

    func FfiOHOSGetTitleButtonRect(id: Int64, retPtr: CPointer<CTitleButtonRect>): Int32

    func FfiOHOSSetDialogBackGestureEnabled(id: Int64, enabled: Bool): Int32

    func FfiOHOSDisableLandscapeMultiWindow(id: Int64): Int32

    func FfiOHOSEnableLandscapeMultiWindow(id: Int64): Int32

    func FfiOHOSSetWindowGrayScale(id: Int64, grayScale: Float32): Int32

    func FfiOHOSSpecificSystemBarEnabled(id: Int64, name: Int32, enable: Bool, enableAnimation: Bool): Int32

    func FfiOHOSGetWindowSystemBarProperties(id: Int64, systemBarProperties: CPointer<CJBarProperties>): Int32

    func FfiOHOSGetPreferredOrientation(id: Int64, errCode: CPointer<Int32>): UInt32

    func FfiOHOSGetWindowStatus(id: Int64, errCode: CPointer<Int32>): Int32

    func FfiOHOSSetSubWindowModal(id: Int64, isModal: Bool): Int32

    func FfiOHOSMaximize(id: Int64, presentation: Int32): Int32

    func FfiOHOSCreateSubWindowWithOptions(id: Int64, name: CString, option: CSubWindowOptions): RetDataI64

    func FfiOHOSOnNoInteractionDetected(id: Int64, timeout: Int64, callbackId: Int64): Int32

    func FfiOHOSOnCallback(id: Int64, callbackId: Int64, callbackType: CString): Int32

    func FfiOHOSOffCallback(id: Int64, callbackId: Int64, callbackType: CString): Int32

    func FFIGetContext(id: Int64): CPointer<Unit>
}

let registerMutex = Mutex()

/**
* Finds a window based on the name.
*
* @param { String } name - Window name, that is, the value of name in Configuration.
* @returns { Window } Window found.
* @throws { BusinessException } 1300002 - This window state is abnormal.
* @relation export function findWindow(name: string): Window
*/
@!APILevel[
    21,
    stagemodelonly: true,
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public func findWindow(name: String): Window {
    unsafe {
        var cValue: ?RetDataI64 = None
        try (cString = LibC.mallocCString(name).asResource()) {
            cValue = FFiOHOSWindowFindWindow(cString.value)
        }
        checkRet(cValue.getOrThrow().code, "[Window] findWindow: ")
        let id = cValue.getOrThrow().data
        getOrCreate(Window.instanceMap, id, {id: Int64 => Window(id)})
    }
}

/**
* Create a window with a specific configuration
* When config.windowType == TYPE_FLOAT, the "ohos.permission.SYSTEM_FLOAT_WINDOW" permission is required
*
* @param { Configuration } config - Parameters for window creation.
* @returns { Window } the window created.
* @throws { IllegalArgumentException } - The context type is not supported. Only support UIAbilityContext.
* @throws { BusinessException } 201 - Permission verification failed. The application does not have the permission required to call the API.
* @throws { BusinessException } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified; 
*                                                                      2. Incorrect parameter types.
* @throws { BusinessException } 1300003 - This window manager service works abnormally.
* @throws { BusinessException } 1300006 - This window context is abnormal.
* @relation export function createWindow(config: Configuration): Promise<Window>
*/
@!APILevel[
    21,
    permission: "ohos.permission.SYSTEM_FLOAT_WINDOW",
    stagemodelonly: true,
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public func createWindow(config: Configuration): Window {
    unsafe {
        let stageContext = unsafe {
            FFIGetContext(config.ctx.getID())
        }
        if (stageContext.isNull()) {
            throw IllegalArgumentException("only UIAbilityContext is supported")
        }
        if (config.name.isEmpty()) {
            checkRet(401, "[Window] createWindow: ")
        }
        var ret: ?RetDataI64 = None
        try (cname = LibC.mallocCString(config.name).asResource()) {
            ret = FfiOHOSCreateWindow(cname.value, config.windowType.getValue(), stageContext, config.displayId, config.parentId)
        }
        checkRet(ret.getOrThrow().code, "[Window] createWindow: ")
        getOrCreate(Window.instanceMap, ret.getOrThrow().data, {id: Int64 => Window(id)})
    }
}

/**
* Obtains the top window of the current application.
* If no child window is available, the main window of the application is returned.
*
* @param { BaseContext } ctx - Current application context.
* @returns { Window } the top window obtained.
* @throws { IllegalArgumentException } - The context type is not supported. Only support UIAbilityContext.
* @throws { BusinessException } 1300002 - This window state is abnormal. Top window or main window is null or destroyed.
* @relation export function getLastWindow(ctx: BaseContext): Promise<Window>
*/
@!APILevel[
    21,
    stagemodelonly: true,
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public func getLastWindow(ctx: BaseContext): Window {
    unsafe {
        let stageContext = unsafe {
            FFIGetContext(ctx.getID())
        }
        if (stageContext.isNull()) {
            throw IllegalArgumentException("only UIAbilityContext is supported")
        }
        let ret = FfiOHOSGetLastWindow(stageContext)
        checkRet(ret.code, "[Window] getLastWindow: ")
        getOrCreate(Window.instanceMap, ret.data, {id: Int64 => Window(id)})
    }
}

/**
* Shifts the window focus from the source window to the target window in the same application.
* The window focus can be shifted between the main window and a child window.
*
* @param { Int32 } sourceWindowId - Window id which the focus shift from.
* @param { Int32 } targetWindowId - Window id which the focus shift to.
* @throws { BusinessException } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified; 
*                                                                      2. Incorrect parameter types.
* @throws { BusinessException } 801 - Capability not supported. Failed to call the API due to limited device capabilities.
* @throws { BusinessException } 1300002 - This window state is abnormal.
* @throws { BusinessException } 1300003 - This window manager service works abnormally.
* @throws { BusinessException } 1300004 - Unauthorized operation.
* @relation export function shiftAppWindowFocus(sourceWindowId: number, targetWindowId: number): Promise<void>
*/
@!APILevel[
    21,
    stagemodelonly: true,
    syscap: "SystemCapability.Window.SessionManager"
]
public func shiftAppWindowFocus(sourceWindowId: Int32, targetWindowId: Int32): Unit {
    unsafe {
        let ret = FfiOHOSShiftAppWindowFocus(sourceWindowId, targetWindowId)
        checkRet(ret, "[Window] shiftAppWindowFocus: ")
    }
}

/**
* Window
*
* @relation export interface Window
*/
@!APILevel[
    21,
    stagemodelonly: true,
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public class Window <: RemoteDataLite {
    let callbackMaps = HashMap<String, ArrayList<(CallbackObject, Int64)>>(
        [
            ("windowSizeChange", ArrayList<(CallbackObject, Int64)>()),
            ("avoidAreaChange", ArrayList<(CallbackObject, Int64)>()),
            ("keyboardHeightChange", ArrayList<(CallbackObject, Int64)>()),
            ("touchOutside", ArrayList<(CallbackObject, Int64)>()),
            ("screenshot", ArrayList<(CallbackObject, Int64)>()),
            ("dialogTargetTouch", ArrayList<(CallbackObject, Int64)>()),
            ("windowEvent", ArrayList<(CallbackObject, Int64)>()),
            ("windowVisibilityChange", ArrayList<(CallbackObject, Int64)>()),
            ("windowStatusChange", ArrayList<(CallbackObject, Int64)>()),
            ("windowTitleButtonRectChange", ArrayList<(CallbackObject, Int64)>()),
            ("noInteractionDetected", ArrayList<(CallbackObject, Int64)>()),
            ("windowRectChange", ArrayList<(CallbackObject, Int64)>()),
            ("subWindowClose", ArrayList<(CallbackObject, Int64)>())
        ]
    )

    static let instanceMap = HashMap<Int64, Window>()

    init(id: Int64) {
        super(id)
        WindowLibLog.info("[Window] construct success")
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
    * Shows this window. 
    * This API takes effect only for a system window or an application child window.
    * For the main window of an application, this API moves it at the top when the main window is already displayed.
    *
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @relation showWindow(): Promise<void>
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func showWindow(): Unit {
        unsafe {
            let ret = FfiOHOSWindowShowWindow(getID())
            checkRet(ret, "[Window] showWindow: ")
        }
    }

    /**
    * Set the position of a window.
    *
    * @param { Int32 } x - Indicate the X-coordinate of the window.
    * @param { Int32 } y - Indicate the Y-coordinate of the window.
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @relation moveWindowTo(x: number, y: number): Promise<void>
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func moveWindowTo(x: Int32, y: Int32): Unit {
        unsafe {
            let ret = FfiOHOSWindowMoveWindowTo(getID(), x, y)
            checkRet(ret, "[Window] moveWindowTo: ")
        }
    }

    /**
    * Set the size of a window.
    *
    * @param { Int32 } width - Indicates the width of the window. The width should be greater than 0.
    * @param { Int32 } height - Indicates the height of the window. The height should be greater than 0.
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @relation resize(width: number, height: number): Promise<void>
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func resize(width: UInt32, height: UInt32): Unit {
        unsafe {
            let ret = FfiOHOSWindowResize(getID(), width, height)
            checkRet(ret, "[Window] resize: ")
        }
    }

    /**
    * Get the properties of current window
    *
    * @returns { WindowProperties } Return the window properties.
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @relation getWindowProperties(): WindowProperties
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func getWindowProperties(): WindowProperties {
        unsafe {
            var errCode: Int32 = 0
            let res = FfiOHOSWindowGetWindowProperties(getID(), inout errCode)
            checkRet(errCode, "[Window] getWindowProperties: ")
            return res.toWindowProperties()
        }
    }

    /**
    * Destroys this window. 
    * This API takes effect only for a system window or an application child window.
    *
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @relation destroyWindow(): Promise<void>
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func destroyWindow(): Unit {
        unsafe {
            let ret = FfiOHOSWindowDestroyWindow(getID())
            checkRet(ret, "[Window] destroyWindow: ")
        }
    }

    /**
    * Sets whether the main window layout or the child window layout is immersive.
    *
    * @param { Bool } isLayoutFullScreen - Whether the window layout is immersive
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @relation setWindowLayoutFullScreen(isLayoutFullScreen: boolean): Promise<void>
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func setWindowLayoutFullScreen(isLayoutFullScreen: Bool): Unit {
        unsafe {
            let ret = FfiOHOSWindowSetWindowLayoutFullScreen(getID(), isLayoutFullScreen)
            checkRet(ret, "[Window] setWindowLayoutFullScreen: ")
        }
    }

    /**
    * Whether the window supports thr wide gamut setting.
    *
    * @returns { Bool } The value true means that the wide-gamut color space is supported, and false means the opposite.
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @relation isWindowSupportWideGamut(): Promise<boolean>
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func isWindowSupportWideGamut(): Bool {
        unsafe {
            var errCode: Int32 = 0
            let res = FfiOHOSWindowIsWindowSupportWideGamut(getID(), inout errCode)
            checkRet(errCode, "[Window] isWindowSupportWideGamut: ")
            return res
        }
    }

    /**
    * Whether the window supports thr wide gamut setting.
    *
    * @returns { Bool }  Whether the window is displayed. The value true means that the window is displayed, and false means the opposite.
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @relation isWindowShowing(): boolean
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func isWindowShowing(): Bool {
        unsafe {
            var errCode: Int32 = 0
            let res = FfiOHOSWindowIsWindowShowing(getID(), inout errCode)
            checkRet(errCode, "[Window] isWindowShowing: ")
            return res
        }
    }


    /**
    * Sets the background color of window.
    *
    * @param { String } color - the specified color.
    * @throws { BusinessException } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified; 
    *                                                                      2. Incorrect parameter types.
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @relation setWindowBackgroundColor(color: string | ColorMetrics): void
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func setWindowBackgroundColor(color: String): Unit {
        unsafe {
            try (rowColor = LibC.mallocCString(color).asResource()) {
                let ret = FfiOHOSSetWindowBackgroundColor(getID(), rowColor.value)
                checkRet(ret, "[Window] setWindowBackgroundColor: ")
            }
        }
    }

    /**
    * Sets the brightness of window.
    *
    * @param { Float32 } brightness the specified brightness value.
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @relation setWindowBrightness(brightness: number): Promise<void>
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func setWindowBrightness(brightness: Float32): Unit {
        unsafe {
            let ret = FfiOHOSWindowSetWindowBrightness(getID(), brightness)
            checkRet(ret, "[Window] setWindowBrightness: ")
        }
    }

    /**
    * Sets whether focusable or not.
    *
    * @param { Bool } isFocusable can be focus if true, or can not be focus if false.
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @relation setWindowFocusable(isFocusable: boolean): Promise<void>
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func setWindowFocusable(isFocusable: Bool): Unit {
        unsafe {
            let ret = FfiOHOSWindowSetWindowFocusable(getID(), isFocusable)
            checkRet(ret, "[Window] setWindowFocusable: ")
        }
    }

    /**
    * Sets whether keep screen on or not.
    *
    * @param { Bool } isKeepScreenOn keep screen on if true, or not if false.
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @relation setWindowKeepScreenOn(isKeepScreenOn: boolean): Promise<void>
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func setWindowKeepScreenOn(isKeepScreenOn: Bool): Unit {
        unsafe {
            let ret = FfiOHOSWindowSetWindowKeepScreenOn(getID(), isKeepScreenOn)
            checkRet(ret, "[Window] setWindowKeepScreenOn: ")
        }
    }

    /**
    * Sets whether is private mode or not.
    *
    * @param { Bool } isPrivacyMode in private mode if true, or not if false.
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @relation setWindowPrivacyMode(isPrivacyMode: boolean): Promise<void>
    */
    @!APILevel[
        21,
        permission: "ohos.permission.PRIVACY_WINDOW",
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func setWindowPrivacyMode(isPrivacyMode: Bool): Unit {
        unsafe {
            let ret = FfiOHOSWindowSetWindowPrivacyMode(getID(), isPrivacyMode)
            checkRet(ret, "[Window] setWindowPrivacyMode: ")
        }
    }

    /**
    * Sets whether is touchable or not
    *
    * @param { Bool } isTouchable is touchable if true, or not if false.
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @relation setWindowTouchable(isTouchable: boolean): Promise<void>
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func setWindowTouchable(isTouchable: Bool): Unit {
        unsafe {
            let ret = FfiOHOSWindowSetWindowTouchable(getID(), isTouchable)
            checkRet(ret, "[Window] setWindowTouchable: ")
        }
    }

    /**
    * Sets the preferred orientation for the main window.
    * It does not take effect on devices that do not support rotation with the sensor, on 2-in-1 devices or for the child window.
    *
    * @param { Orientation } orientation - The orientation config of the window
    * @throws { BusinessException } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified; 
    *                                                                      2. Incorrect parameter types; 
    *                                                                      3. Parameter verification failed.
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @relation setPreferredOrientation(orientation: Orientation): Promise<void>
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func setPreferredOrientation(orientation: Orientation): Unit {
        let code = unsafe { FFiOHOSWindowSetPreferredOrientation(getID(), orientation.getValue()) }
        checkRet(code, "[Window] setPreferredOrientation: ")
    }

    /**
    * Get the avoid area
    *
    * @param { AvoidAreaType } areaType - Type of the area
    * @returns { AvoidArea } Area where the window cannot be displayed.
    * @throws { BusinessException } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified; 
    *                                                                      2. Incorrect parameter types; 
    *                                                                      3. Parameter verification failed.
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @relation getWindowAvoidArea(type: AvoidAreaType): AvoidArea
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func getWindowAvoidArea(areaType: AvoidAreaType): AvoidArea {
        unsafe {
            var cAvoidArea: CAvoidArea = CAvoidArea(false, CRect(0, 0, 0, 0), CRect(0, 0, 0, 0), CRect(0, 0, 0, 0),
                CRect(0, 0, 0, 0))
            let code = FFiOHOSWindowGetWindowAvoidArea(getID(), areaType.getValue(), inout cAvoidArea)
            checkRet(code, "[Window] getWindowAvoidArea: ")
            return AvoidArea(cAvoidArea)
        }
    }

    /**
    * Sets the aspect ratio of window
    *
    * @param { Float64 } ratio - The aspect ratio of window except decoration
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @throws { BusinessException } 1300004 - Unauthorized operation.
    * @relation setAspectRatio(ratio: number): Promise<void>
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func setAspectRatio(ratio: Float64): Unit {
        let code = unsafe { FFiOHOSWindowSetAspectRatio(getID(), ratio) }
        checkRet(code, "[Window] setAspectRatio: ")
    }

    /**
    * Resets the aspect ratio of window
    *
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @throws { BusinessException } 1300004 - Unauthorized operation.
    * @relation resetAspectRatio(): Promise<void>
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func resetAspectRatio(): Unit {
        let code = unsafe { FFiOHOSWindowResetAspectRatio(getID()) }
        checkRet(code, "[Window] resetAspectRatio: ")
    }

    /**
    * Sets the specified color space.
    *
    * @param { ColorSpace } colorSpace - the specified color space.
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @relation setWindowColorSpace(colorSpace: ColorSpace): Promise<void>
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func setWindowColorSpace(colorSpace: ColorSpace): Unit {
        unsafe {
            let ret = FFiOHOSWindowSetWindowColorSpace(getID(), colorSpace.getValue())
            checkRet(ret, "[Window] setWindowColorSpace: ")
        }
    }

    /**
    * Minimizes the main window if the caller is the main window. The main window can be restored in the dock bar. For 2-in-1 devices, it can be restored by calling restore().
    * Hides the child window if the caller is a child window. The child window cannot be restored in the dock bar. It can be made visible again by calling showWindow().
    *
    * @throws { BusinessException } 801 - Capability not supported. Failed to call the API due to limited device capabilities.
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @relation minimize(): Promise<void>
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Window.SessionManager"
    ]
    public func minimize(): Unit {
        unsafe {
            let ret = FFiOHOSWindowMinimize(getID())
            checkRet(ret, "[Window] minimize: ")
        }
    }

    /**
    * Obtains the set color space.
    *
    * @returns { ColorSpace } Color space obtained.
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @relation getWindowColorSpace(): ColorSpace
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func getWindowColorSpace(): ColorSpace {
        unsafe {
            var errCode: Int32 = 0
            let res = FFiOHOSWindowGetWindowColorSpace(getID(), inout errCode)
            checkRet(errCode, "[Window] getWindowColorSpace: ")
            return ColorSpace.parse(Int32(res))
        }
    }

    /**
    * Obtains snapshot of window
    *
    * @returns { PixelMap } Promise that returns no value.
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @relation snapshot(): Promise<image.PixelMap>
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func snapshot(): PixelMap {
        unsafe {
            var errCode: Int32 = 0
            let id = FFiOHOSWindowSnapshot(getID(), inout errCode)
            checkRet(errCode, "[Window] snapshot: ")
            return PixelMap(id)
        }
    }

    /**
    * Sets whether to show the system bar of the main window.
    *
    * @param { Array<SystemBarType> } names - The set of system bar types
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @relation setWindowSystemBarEnable(names: Array<'status' | 'navigation'>): Promise<void>
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func setWindowSystemBarEnable(names: Array<SystemBarType>): Unit {
        unsafe {
            let arrNames = Array<String>(names.size, repeat: "")
            for (i in 0..names.size) {
                arrNames[i] = names[i].getValue()
            }
            let arr = toArrayCString(arrNames)
            let ret = FFiOHOSWindowSetWindowSystemBarEnable(getID(), arr)
            freeArrCString(arr)
            checkRet(ret, "[Window] setWindowSystemBarEnable: ")
        }
    }

    /**
    * Set the properties of system bar
    *
    * @param { SystemBarProperties } systemBarProperties - The properties of system bar
    * @throws { BusinessException } 1300002 - This window state is abnormal.
    * @relation setWindowSystemBarProperties(systemBarProperties: SystemBarProperties): Promise<void>
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func setWindowSystemBarProperties(systemBarProperties: SystemBarProperties): Unit {
        unsafe {
            try (
                v1 = LibC.mallocCString(systemBarProperties.statusBarColor).asResource(),
                v2 = LibC.mallocCString(systemBarProperties.statusBarContentColor).asResource(),
                v3 = LibC.mallocCString(systemBarProperties.navigationBarColor).asResource(),
                v4 = LibC.mallocCString(systemBarProperties.navigationBarContentColor).asResource()
            ) {
                let properties = CJBarProperties(v1.value, systemBarProperties.isStatusBarLightIcon, v2.value, v3.value,
                    systemBarProperties.isNavigationBarLightIcon, v4.value, systemBarProperties.enableStatusBarAnimation,
                    systemBarProperties.enableNavigationBarAnimation)
                let ret = FFiOHOSWindowSetWindowSystemBarProperties(getID(), properties)
                checkRet(ret, "[Window] setWindowSystemBarProperties: ")
                properties.freeCStringMember()
            }
        }
    }

    func findCallbackObject(list: ArrayList<(CallbackObject, Int64)>, callback: CallbackObject): Bool {
        for (item in list) {
            if (refEq(callback, item[0])) {
                return true
            }
        }
        false
    }

    /**
    * Register the callback of keyboardHeightChange
    *
    * @param { WindowCallbackType } callbackType - The value is fixed at KeyboardHeightChange, indicating the keyboard height change event.
    * @param { Callback1Argument<UInt32> } callback - Callback used to return the current keyboard height, which is an integer, in px.
    * @throws { BusinessException } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified; 
    *                                                                      2. Incorrect parameter types; 
    *                                                                      3. Parameter verification failed.
    * @relation on(type: 'keyboardHeightChange', callback: Callback<number>): void
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func on(callbackType: WindowCallbackType, callback: Callback1Argument<UInt32>): Unit {
        match (callbackType) {
            case KeyboardHeightChange => onKeyboardHeightChange(callbackType.getValue(), callback)
            case _ => throw IllegalArgumentException("Invalid param.")
        }
    }

    func onKeyboardHeightChange(callbackType: String, callback: Callback1Argument<UInt32>): Unit {
        synchronized(registerMutex) {
            var value = callbackMaps.entryView(callbackType)
            if (value.value.isNone() || callbackType != "keyboardHeightChange") {
                WindowLibLog.error("[Window] Invalid param.")
                return
            }
            if (findCallbackObject(value.value.getOrThrow(), callback)) {
                WindowLibLog.info("[Window] The callback object already exists.")
                return
            }
            unsafe {
                let wrapper = {
                    data: CPointer<Unit> =>
                    let val = CPointer<UInt32>(data).read()
                    callback.invoke(None, val)
                }
                let registerCall = Callback1Param<CPointer<Unit>, Unit>(wrapper)
                var ret: ?Int32 = None
                try (callbackTypeCString = LibC.mallocCString(callbackType).asResource()) {
                    ret = FfiOHOSOnCallback(getID(), registerCall.getID(), callbackTypeCString.value)
                }
                checkRet(ret.getOrThrow(), "[Window] Register ${callbackType} failed: ")
                value.value.getOrThrow().add((callback, registerCall.getID()))
            }
        }
    }

    /**
    * Unregister the callback of keyboardHeightChange
    *
    * @param { WindowCallbackType } callbackType - The value is fixed at KeyboardHeightChange, indicating the keyboard height change event.
    * @param { Callback1Argument<UInt32> } callback - Callback used to return the current keyboard height, which is an integer, in px.
    * @throws { BusinessException } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified; 
    *                                                                      2. Incorrect parameter types; 
    *                                                                      3. Parameter verification failed.
    * @relation off(type: 'keyboardHeightChange', callback?: Callback<number>): void
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func off(callbackType: WindowCallbackType, callback: Callback1Argument<UInt32>): Unit {
        match (callbackType) {
            case KeyboardHeightChange => commonUnregister<Callback1Argument<UInt32>>(callbackType.getValue(), callback)
            case _ => throw IllegalArgumentException("Invalid param.")
        }
    }

    /**
    * Unregister the callback of the specified event
    *
    * @param { WindowCallbackType } callbackType - the event type
    * @throws { BusinessException } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified; 
    *                                                                      2. Incorrect parameter types; 
    *                                                                      3. Parameter verification failed.
    */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public func off(callbackType: WindowCallbackType): Unit {
        match (callbackType) {
            case WindowRectChange | WindowTitleButtonRectChange | WindowStatusChange | WindowEvent | WindowSizeChange
                | KeyboardHeightChange | TouchOutside | SubWindowClose | DialogTargetTouch | Screenshot
                | NoInteractionDetected | WindowVisibilityChange | WindowAvoidAreaChange => commonUnregister(
                callbackType.getValue())
            case _ => throw IllegalArgumentException("Invalid param.")
        }
    }

    func commonUnregister(callbackType: String): Unit {
        synchronized(registerMutex) {
            var value = callbackMaps.entryView(callbackType)
            if (value.value.isNone()) {
                WindowLibLog.error("[Window] Invalid param.")
                return
            }
            unsafe {
                var ret: ?Int32 = None
                try (callbackTypeCString = LibC.mallocCString(callbackType).asResource()) {
                    ret = FfiOHOSOffCallback(getID(), -1, callbackTypeCString.value)
                }
                checkRet(ret.getOrThrow(), "[Window] Unregister ${callbackType} failed: ")
                value.value.getOrThrow().clear()
            }
        }
    }

    func commonUnregister<T>(callbackType: String, callback: T): Unit where T <: CallbackObject {
        synchronized(registerMutex) {
            var callbackEntryView = callbackMaps.entryView(callbackType)
            if (callbackEntryView.value.isNone()) {
                WindowLibLog.error("[Window] Invalid param.")
                return
            }
            var callbackId: Option<Int64> = None
            var callbackList = callbackEntryView.value.getOrThrow()
            for (idx in 0..callbackList.size) {
                if (refEq(callback, callbackList[idx][0])) {
                    callbackId = callbackList[idx][1]
                    callbackList.remove(idx..idx + 1)
                    break
                }
            }
            if (callbackId.isNone()) {
                WindowLibLog.info("[Window] The callback object not exists.")
                return
            }
            unsafe {
                var ret: ?Int32 = None
                try (callbackTypeCString = LibC.mallocCString(callbackType).asResource()) {
                    WindowLibLog.info("[Window] The callback QDY id = ${callbackId.getOrThrow()}")
                    ret = FfiOHOSOffCallback(getID(), callbackId.getOrThrow(), callbackTypeCString.value)
                }
                checkRet(ret.getOrThrow(), "[Window] Unregister ${callbackType} failed: ")
            }
        }
    }
}
