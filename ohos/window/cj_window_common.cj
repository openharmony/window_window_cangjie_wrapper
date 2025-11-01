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

import ohos.app.ability.BaseContext
import ohos.labels.APILevel

/**
 * Window size.
 *
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public class Size {
    /**
     * The width of the window.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var width: UInt32
    /**
     * The height of the window.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var height: UInt32

    /**
     * Size constructor.
     * @params { UInt32 } width
     * @params { UInt32 } height
     */
    @!APILevel[
        since: "22",
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
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Window.SessionManager"
]
public class TitleButtonRect {
    /**
     * The right of the Rect.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    public var right: Int32
    /**
     * The top of the Rect.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    public var top: Int32
    /**
     * The width of the Rect.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    public var width: UInt32
    /**
     * The height of the Rect.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    public var height: UInt32

    /**
     * TitleButtonRect constructor.
     * @params { Int32 } right
     * @params { Int32 } top
     * @params { UInt32 } width
     * @params { UInt32 } height
     */
    @!APILevel[
        since: "22",
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
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public class Configuration {
    /**
     * Indicates window id.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var name: String
    /**
     * Indicates window type.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var windowType: WindowType
    /**
     * Indicates window context.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var ctx: BaseContext
    /**
     * Indicates display ID.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var displayId: Int64 = -1
    /**
     * Indicates Parent window id.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var parentId: Int64 = -1

    /**
     * Configuration constructor.
     * @params { String } name
     * @params { WindowType } windowType
     * @params { BaseContext } ctx
     * @params { Int64 } displayId
     * @params { Int64 } parentId
     */
    @!APILevel[
        since: "22",
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
 * Rectangle.
 *
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public class Rect {
    /**
     * The left of the Rect.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var left: Int32
    /**
     * The top of the Rect.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var top: Int32
    /**
     * The width of the Rect.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var width: UInt32
    /**
     * The height of the Rect.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var height: UInt32

    /**
     * Rect constructor.
     * @params { Int32 } left
     * @params { Int32 } top
     * @params { UInt32 } width
     * @params { UInt32 } height
     */
    @!APILevel[
        since: "22",
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
 * Properties of window, it couldn't update automatically.
 *
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public class WindowProperties {
    /**
     * The position and size of the window.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var windowRect: Rect
    /**
     * The position relative to the window and size of drawable area.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var drawableRect: Rect
    /**
     * Window type.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var winType: WindowType
    /**
     * Whether the window is displayed in full screen mode. The default value is false.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var isFullScreen: Bool
    /**
     * Whether the window layout is in full screen mode(whether the window is immersive). The default value is false.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var isLayoutFullScreen: Bool
    /**
     * Whether the window can gain focus. The default value is true.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var focusable: Bool
    /**
     * Whether the window is touchable. The default value is false.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var touchable: Bool
    /**
     * Brightness value of window.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var brightness: Float32
    /**
     * Whether keep screen on.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var isKeepScreenOn: Bool
    /**
     * Whether make window in privacy mode or not.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var isPrivacyMode: Bool
    /**
     * Whether is transparent or not.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var isTransparent: Bool
    /**
     * isTransparent: boolean
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var id: UInt32

    /**
     * WindowProperties constructor.
     * @params { Rect } windowRect
     * @params { Rect } drawableRect
     * @params { WindowType } winType
     * @params { Bool } isFullScreen
     * @params { Bool } isLayoutFullScreen
     * @params { Bool } focusable
     * @params { Bool } touchable
     * @params { Float32 } brightness
     * @params { Bool } isKeepScreenOn
     * @params { Bool } isPrivacyMode
     * @params { Bool } isTransparent
     * @params { UInt32 } id
     */
    @!APILevel[
        since: "22",
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
        return WindowProperties(windowRect: windowRect.toRect(), drawableRect: drawableRect.toRect(),
            winType: WindowType.parse(winType), isFullScreen: isFullScreen, isLayoutFullScreen: isLayoutFullScreen,
            focusable: focusable, touchable: touchable, brightness: brightness, isKeepScreenOn: isKeepScreenOn,
            isPrivacyMode: isPrivacyMode, isTransparent: isTransparent, id: id)
    }
}

/**
 * Avoid area.
 *
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public class AvoidArea {
    /**
     * Whether avoidArea is visible on screen.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var visible: Bool
    /**
     * Rectangle on the left of the screen.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var leftRect: Rect
    /**
     * Rectangle on the top of the screen.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var topRect: Rect
    /**
     * Rectangle on the right of the screen.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var rightRect: Rect
    /**
     * Rectangle on the bottom of the screen.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var bottomRect: Rect

    /**
     * AvoidArea constructor.
     * @params { Bool } visible
     * @params { Rect } leftRect
     * @params { Rect } topRect
     * @params { Rect } rightRect
     * @params { Rect } bottomRect
     */
    @!APILevel[
        since: "22",
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
 * Properties of status bar and navigation bar, it couldn't update automatically.
 *
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public class SystemBarProperties {
    /**
     * The color of the status bar.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var statusBarColor: String = "#66000000"
    /**
     * The light icon of the status bar.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var isStatusBarLightIcon: Bool = false
    /**
     * The content color of the status bar.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var statusBarContentColor: String = "#E5FFFFFF"
    /**
     * statusBarContentColor?: string
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var navigationBarColor: String = "#66000000"
    /**
     * navigationBarColor?: string
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var isNavigationBarLightIcon: Bool = false
    /**
     * The content color of the navigation bar.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    public var navigationBarContentColor: String = "#E5FFFFFF"
    /**
     * Enable the animation of the status bar.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    public var enableStatusBarAnimation: Bool = false
    /**
     * Enable the animation of the navigation bar.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    public var enableNavigationBarAnimation: Bool = false

    /**
     * SystemBarProperties constructor.
     * @params { String } statusBarColor
     * @params { Bool } isStatusBarLightIcon
     * @params { String } statusBarContentColor
     * @params { String } navigationBarColor
     * @params { Bool } isNavigationBarLightIcon
     * @params { String } navigationBarContentColor
     * @params { Bool } enableStatusBarAnimation
     * @params { Bool } enableNavigationBarAnimation
     */
    @!APILevel[
        since: "22",
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
