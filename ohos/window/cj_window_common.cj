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

internal import ohos.labels.*
import ohos.app.ability.BaseContext

/**
* Window size
*
* @relation export interface Size
*/
@!APILevel[
    since: "21",
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public class Size {
    /**
    * The width of the window.
    *
    * @relation width: number
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var width: UInt32
    /**
    * The height of the window.
    *
    * @relation height: number
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var height: UInt32

    /**
    * Size constructor.
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public init(
        width!: UInt32,
        height!: UInt32
    ) {
        this.width = width
        this.height = height
    }

    func toExternal(): CSize {
        return CSize(width, height)
    }

    init(cSize: CSize) {
        this.width = cSize.width
        this.height = cSize.height
    }
}

@C
struct CSize {
    CSize(
        let width: UInt32,
        let height: UInt32
    ) {}

    func toSize(): Size {
        return Size(width: width, height: height)
    }
}

/**
* Rectangular area of the title buttons relative to the upper right corner of the window.
*
* @relation export interface TitleButtonRect
*/
@!APILevel[
    since: "21",
    syscap: "SystemCapability.Window.SessionManager"
]
public class TitleButtonRect {
    /**
    * The right of the Rect.
    *
    * @relation right: number
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    public var right: Int32
    /**
    * The top of the Rect.
    *
    * @relation top: number
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    public var top: Int32
    /**
    * The width of the Rect.
    *
    * @relation width: number
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    public var width: UInt32
    /**
    * The height of the Rect.
    *
    * @relation height: number
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    public var height: UInt32
    
    /**
    * TitleButtonRect constructor.
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    public init(
        right!: Int32,
        top!: Int32,
        width!: UInt32,
        height!: UInt32
    ) {
        this.right = right
        this.top = top
        this.width = width
        this.height = height
    }

    func toExternal(): CTitleButtonRect {
        return CTitleButtonRect(right, top, width, height)
    }

    init(cTitleButtonRect: CTitleButtonRect) {
        this.right = cTitleButtonRect.right
        this.top = cTitleButtonRect.top
        this.width = cTitleButtonRect.width
        this.height = cTitleButtonRect.height
    }
}

@C
struct CTitleButtonRect {
    CTitleButtonRect(
        let right: Int32,
        let top: Int32,
        let width: UInt32,
        let height: UInt32
    ) {}

    func toTitleButtonRect(): TitleButtonRect {
        return TitleButtonRect(right: right, top: top, width: width, height: height)
    }
}

@C
struct RetStruct {
    RetStruct(
        let code: Int32,
        let len: Int64,
        let data: CPointer<Unit>
    ) {}
}

/**
* Configuration parameters for window creation.
*
* @relation export interface Configuration
*/
@!APILevel[
    since: "21",
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public class Configuration {
    /**
    * Indicates window id.
    *
    * @relation name: string
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var name: String
    /**
    * Indicates window type
    *
    * @relation windowType: WindowType
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var windowType: WindowType
    /**
    * Indicates window context.
    *
    * @relation ctx?: BaseContext
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var ctx: BaseContext
    /**
    * Indicates display ID.
    *
    * @relation displayId?: number
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var displayId: Int64 = -1
    /**
    * Indicates Parent window id
    *
    * @relation parentId?: number
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var parentId: Int64 = -1

    /**
    * Configuration constructor.
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public init(
        name!: String,
        windowType!: WindowType,
        ctx!: BaseContext,
        displayId!: Int64 = -1,
        parentId!: Int64 = -1
    ) {
        this.name = name
        this.windowType = windowType
        this.ctx = ctx
        this.displayId = displayId
        this.parentId = parentId
    }
}

/**
* Rectangle
*
* @relation export interface Rect
*/
@!APILevel[
    since: "21",
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public class Rect {
    /**
    * The left of the Rect.
    *
    * @relation left: number
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var left: Int32
    /**
    * The top of the Rect.
    *
    * @relation top: number
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var top: Int32
    /**
    * The width of the Rect.
    *
    * @relation width: number
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var width: UInt32
    /**
    * The height of the Rect.
    *
    * @relation height: number
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var height: UInt32

    /**
    * Rect constructor.
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public init(
        left!: Int32,
        top!: Int32,
        width!: UInt32,
        height!: UInt32
    ) {
        this.left = left
        this.top = top
        this.width = width
        this.height = height
    }

    func toExternal(): CRect {
        return CRect(left, top, width, height)
    }

    init(cRect: CRect) {
        this.left = cRect.left
        this.top = cRect.top
        this.width = cRect.width
        this.height = cRect.height
    }
}

@C
struct CRect {
    CRect(
        let left: Int32,
        let top: Int32,
        let width: UInt32,
        let height: UInt32
    ) {}

    func toRect(): Rect {
        return Rect(left: left, top: top, width: width, height: height)
    }
}

/**
* Properties of window, it couldn't update automatically
*
* @relation export interface WindowProperties
*/
@!APILevel[
    since: "21",
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public class WindowProperties {
    /**
    * The position and size of the window
    *
    * @relation windowRect: Rect
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var windowRect: Rect
    /**
    * The position relative to the window and size of drawable area
    *
    * @relation drawableRect: Rect
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var drawableRect: Rect
    /**
    * Window type
    *
    * @relation type: WindowType
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var winType: WindowType
    /**
    * Whether the window is displayed in full screen mode. The default value is false.
    *
    * @relation isFullScreen: boolean
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var isFullScreen: Bool
    /**
    * Whether the window layout is in full screen mode(whether the window is immersive). The default value is false.
    *
    * @relation isLayoutFullScreen: boolean
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var isLayoutFullScreen: Bool
    /**
    * Whether the window can gain focus. The default value is true
    *
    * @relation focusable: boolean
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var focusable: Bool
    /**
    * Whether the window is touchable. The default value is false
    *
    * @relation touchable: boolean
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var touchable: Bool
    /**
    * Brightness value of window.
    *
    * @relation brightness: number
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var brightness: Float32
    /**
    * Whether keep screen on.
    *
    * @relation isKeepScreenOn: boolean;
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var isKeepScreenOn: Bool
    /**
    * Whether make window in privacy mode or not.
    *
    * @relation isPrivacyMode: boolean
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var isPrivacyMode: Bool
    /**
    * Whether is transparent or not.
    *
    * @relation isTransparent: boolean
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var isTransparent: Bool
    /**
    * isTransparent: boolean
    *
    * @relation id: number
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var id: UInt32

    /**
    * WindowProperties constructor.
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public init(
        windowRect!: Rect,
        drawableRect!: Rect,
        winType!: WindowType,
        isFullScreen!: Bool,
        isLayoutFullScreen!: Bool,
        focusable!: Bool,
        touchable!: Bool,
        brightness!: Float32,
        isKeepScreenOn!: Bool,
        isPrivacyMode!: Bool,
        isTransparent!: Bool,
        id!: UInt32
    ) {
        this.windowRect = windowRect
        this.drawableRect = drawableRect
        this.winType = winType
        this.isFullScreen = isFullScreen
        this.isLayoutFullScreen = isLayoutFullScreen
        this.focusable = focusable
        this.touchable = touchable
        this.brightness = brightness
        this.isKeepScreenOn = isKeepScreenOn
        this.isPrivacyMode = isPrivacyMode
        this.isTransparent = isTransparent
        this.id = id
    }
}

@C
struct CWindowProperties {
    CWindowProperties(
        let windowRect: CRect,
        let drawableRect: CRect,
        let winType: UInt32,
        let isFullScreen: Bool,
        let isLayoutFullScreen: Bool,
        let focusable: Bool,
        let touchable: Bool,
        let brightness: Float32,
        let isKeepScreenOn: Bool,
        let isPrivacyMode: Bool,
        let isRoundCorner: Bool,
        let isTransparent: Bool,
        let id: UInt32
    ) {}

    func toWindowProperties(): WindowProperties {
        return WindowProperties(
            windowRect: windowRect.toRect(), 
            drawableRect: drawableRect.toRect(), 
            winType: WindowType.parse(winType), 
            isFullScreen: isFullScreen,
            isLayoutFullScreen: isLayoutFullScreen, 
            focusable: focusable, 
            touchable: touchable, 
            brightness: brightness, 
            isKeepScreenOn: isKeepScreenOn, 
            isPrivacyMode: isPrivacyMode,
            isTransparent: isTransparent, 
            id: id)
    }
}

/**
* Avoid area
*
* @relation export interface AvoidArea
*/
@!APILevel[
    since: "21",
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public class AvoidArea {
    /**
    * Whether avoidArea is visible on screen
    *
    * @relation visible: boolean
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var visible: Bool
    /**
    * Rectangle on the left of the screen
    *
    * @relation leftRect: Rect
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var leftRect: Rect
    /**
    * Rectangle on the top of the screen
    *
    * @relation topRect: Rect
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var topRect: Rect
    /**
    * Rectangle on the right of the screen
    *
    * @relation rightRect: Rect
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var rightRect: Rect
    /**
    * Rectangle on the bottom of the screen
    *
    * @relation bottomRect: Rect
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var bottomRect: Rect

    /**
    * AvoidArea constructor.
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public init(
        visible!: Bool,
        leftRect!: Rect,
        topRect!: Rect,
        rightRect!: Rect,
        bottomRect!: Rect
    ) {
       this.visible = visible
       this.leftRect = leftRect
       this.topRect = topRect
       this.rightRect = rightRect
       this.bottomRect = bottomRect
    }

    func toExternal(): CAvoidArea {
        return CAvoidArea(visible, leftRect.toExternal(), topRect.toExternal(), rightRect.toExternal(),
            bottomRect.toExternal())
    }

    init(cAvoidArea: CAvoidArea) {
        this.visible = cAvoidArea.visible
        this.leftRect = Rect(cAvoidArea.leftRect)
        this.topRect = Rect(cAvoidArea.topRect)
        this.rightRect = Rect(cAvoidArea.rightRect)
        this.bottomRect = Rect(cAvoidArea.bottomRect)
    }
}

@C
struct CAvoidArea {
    CAvoidArea(
        var visible: Bool,
        var leftRect: CRect,
        var topRect: CRect,
        var rightRect: CRect,
        var bottomRect: CRect
    ) {}
}

/**
* Properties of status bar and navigation bar, it couldn't update automatically
*
* @relation export interface SystemBarProperties
*/
@!APILevel[
    since: "21",
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public class SystemBarProperties {
    /**
    * The color of the status bar.
    *
    * @relation statusBarColor?: string
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var statusBarColor: String = "#66000000"
    /**
    * The light icon of the status bar.
    *
    * @relation isStatusBarLightIcon?: boolean
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var isStatusBarLightIcon: Bool = false
    /**
    * The content color of the status bar
    *
    * @relation statusBarContentColor?: string
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var statusBarContentColor: String = "#E5FFFFFF"
    /**
    * statusBarContentColor?: string
    *
    * @relation navigationBarColor?: string
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var navigationBarColor: String = "#66000000"
    /**
    * navigationBarColor?: string
    *
    * @relation isNavigationBarLightIcon?: boolean
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var isNavigationBarLightIcon: Bool = false
    /**
    * The content color of the navigation bar
    *
    * @relation navigationBarContentColor?: string
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var navigationBarContentColor: String = "#E5FFFFFF"
    /**
    * Enable the animation of the status bar.
    *
    * @relation enableStatusBarAnimation?: boolean
    */
    @!APILevel[
        since: "21",
        atomicservice: true,
        crossplatform: true,
        syscap: "SystemCapability.Window.SessionManager"
    ]
    public var enableStatusBarAnimation: Bool = false
    /**
    * Enable the animation of the navigation bar.
    *
    * @relation enableNavigationBarAnimation?: boolean
    */
    @!APILevel[
        since: "21",
        atomicservice: true,
        crossplatform: true,
        syscap: "SystemCapability.Window.SessionManager"
    ]
    public var enableNavigationBarAnimation: Bool = false

    /**
    * SystemBarProperties constructor.
    */
    @!APILevel[
        since: "21",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public init(
        statusBarColor!: String = "#66000000",
        isStatusBarLightIcon!: Bool = false,
        statusBarContentColor!: String = "#E5FFFFFF",
        navigationBarColor!: String = "#66000000",
        isNavigationBarLightIcon!: Bool = false,
        navigationBarContentColor!: String = "#E5FFFFFF",
        enableStatusBarAnimation!: Bool = false,
        enableNavigationBarAnimation!: Bool = false
    ) {
        this.statusBarColor = statusBarColor
        this.isStatusBarLightIcon = isStatusBarLightIcon
        this.statusBarContentColor = statusBarContentColor
        this.navigationBarColor = navigationBarColor
        this.isNavigationBarLightIcon = isNavigationBarLightIcon
        this.navigationBarContentColor = navigationBarContentColor
        this.enableStatusBarAnimation = enableStatusBarAnimation
        this.enableNavigationBarAnimation = enableNavigationBarAnimation
    }

    init(systemBarProperties: CJBarProperties) {
        this.statusBarColor = systemBarProperties.statusBarColor.toString()
        this.isStatusBarLightIcon = systemBarProperties.isStatusBarLightIcon
        this.statusBarContentColor = systemBarProperties.statusBarContentColor.toString()
        this.navigationBarColor = systemBarProperties.navigationBarColor.toString()
        this.isNavigationBarLightIcon = systemBarProperties.isNavigationBarLightIcon
        this.navigationBarContentColor = systemBarProperties.navigationBarContentColor.toString()
        this.enableStatusBarAnimation = systemBarProperties.enableStatusBarAnimation
        this.enableNavigationBarAnimation = systemBarProperties.enableNavigationBarAnimation
    }
}

@C
struct CJBarProperties {
    CJBarProperties(
        var statusBarColor: CString,
        var isStatusBarLightIcon: Bool,
        var statusBarContentColor: CString,
        var navigationBarColor: CString,
        var isNavigationBarLightIcon: Bool,
        var navigationBarContentColor: CString,
        var enableStatusBarAnimation: Bool,
        var enableNavigationBarAnimation: Bool
    ) {}

    func freeCStringMember(): Unit {
        unsafe {
            LibC.free(statusBarColor)
            LibC.free(statusBarContentColor)
            LibC.free(navigationBarColor)
            LibC.free(navigationBarContentColor)
        }
    } 
}

@C
struct CWindowLimits {
    CWindowLimits(
        var maxWidth: UInt32,
        var maxHeight: UInt32,
        var minWidth: UInt32,
        var minHeight: UInt32
    ) {}
}

@C
struct CSubWindowOptions {
    CSubWindowOptions(
        var title: CString,
        var decorEnabled: Bool,
        var isModal: Bool
    ) {}
}
