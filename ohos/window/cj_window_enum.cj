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

import std.deriving.Derive

/**
 * The type of a window.
 *
 */
@Derive[Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public enum WindowType {
    /**
    * App.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    TypeApp
    |
    /**
    * System alert.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    TypeSystemAlert
    |
    /**
    * Float.
    * Require "ohos.permission.SYSTEM_FLOAT_WINDOW" permission
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    TypeFloat
    |
    /**
    * Dialog.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    TypeDialog
    | ...

    func getValue(): UInt32 {
        return match (this) {
            case TypeApp => 0
            case TypeSystemAlert => 1
            case TypeFloat => 8
            case TypeDialog => 16
            case _ => throw BusinessException(100001, "Internal error.")
        }
    }

    static func parse(val: UInt32) {
        match (val) {
            case 0 => TypeApp
            case 1 => TypeSystemAlert
            case 8 => TypeFloat
            case 16 => TypeDialog
            case 32 => TypeApp
            case _ => throw BusinessException(100001, "Internal error.")
        }
    }
}

/**
* Display orientation.
*
*/
@Derive[Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public enum Orientation {
    /**
    * Default value. The direction mode is not clearly defined. It is determined by the system.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    Unspecified
    |
    /**
    * Display in portrait orientation.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    Portrait
    |
    /**
    * Display in landscape orientation.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    Landscape
    |
    /**
    * Display in inverted portrait orientation.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    PortraitInverted
    |
    /**
    * Display in inverted landscape orientation.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    LandscapeInverted
    |
    /**
    * Follow the rotation of the sensor, ignore auto rotation lock.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    AutoRotation
    |
    /**
    * Follow the rotation of the sensor, only work in the vertical direction, ignore auto rotation lock.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    AutoRotationPortrait
    |
    /**
    * Follow the rotation of the sensor, only work in the horizontal direction, ignore auto rotation lock.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    AutoRotationLandscape
    |
    /**
    * Follow the rotation of the sensor, controlled by auto rotation lock.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    AutoRotationRestricted
    |
    /**
    * Follow the rotation of the sensor, only work in the vertical direction, controlled by auto rotation lock.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    AutoRotationPortraitRestricted
    |
    /**
    * Follow the rotation of the sensor, only work in the horizontal direction, controlled by auto rotation lock.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    AutoRotationLandscapeRestricted
    |
    /**
    * Locked mode, keep the same direction as previous one.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    Locked
    | ...

    func getValue(): UInt32 {
        match (this) {
            case Unspecified => 0
            case Portrait => 1
            case Landscape => 2
            case PortraitInverted => 3
            case LandscapeInverted => 4
            case AutoRotation => 5
            case AutoRotationPortrait => 6
            case AutoRotationLandscape => 7
            case AutoRotationRestricted => 8
            case AutoRotationPortraitRestricted => 9
            case AutoRotationLandscapeRestricted => 10
            case Locked => 11
            case _ => throw BusinessException(100001, "Internal error.")
        }
    }

    static func parse(val: UInt32) {
        match (val) {
            case 0 => Unspecified
            case 1 => Portrait
            case 2 => Landscape
            case 3 => PortraitInverted
            case 4 => LandscapeInverted
            case 5 => AutoRotation
            case 6 => AutoRotationPortrait
            case 7 => AutoRotationLandscape
            case 8 => AutoRotationRestricted
            case 9 => AutoRotationPortraitRestricted
            case 10 => AutoRotationLandscapeRestricted
            case 11 => Locked
            case _ => throw BusinessException(100001, "Internal error.")
        }
    }
}

/**
* Describes the type of avoid area.
*
*/
@Derive[Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public enum AvoidAreaType {
    /**
    * Default area of the system
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    TypeSystem
    |
    /**
    * Notch
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    TypeCutout
    |
    /**
    * Area for system gesture
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    TypeSystemGesture
    |
    /**
    * Area for keyboard
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    TypeKeyboard
    |
    /**
    * Area for navigation indicator
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    TypeNavigationIndicator
    | ...

    func getValue(): UInt32 {
        match (this) {
            case TypeSystem => 0
            case TypeCutout => 1
            case TypeSystemGesture => 2
            case TypeKeyboard => 3
            case TypeNavigationIndicator => 4
            case _ => throw BusinessException(100001, "Internal error.")
        }
    }

    static func parse(val: Int32) {
        match (val) {
            case 0 => TypeSystem
            case 1 => TypeCutout
            case 2 => TypeSystemGesture
            case 3 => TypeKeyboard
            case 4 => TypeNavigationIndicator
            case _ => throw BusinessException(100001, "Internal error.")
        }
    }
}

/**
* Enum for window callback event type.
*
*/
@Derive[Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public enum WindowEventType {
    /**
    * The value of window event is window show
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    WindowShown
    |
    /**
    * The value of window event is window active
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    WindowActive
    |
    /**
    * The value of window event is window inactive
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    WindowInactive
    |
    /**
    * The value of window event is window hide
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    WindowHidden
    |
    /**
    * The value of window event is window destroy
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.Window.SessionManager"
    ]
    WindowDestroyed
    | ...

    func getValue(): UInt32 {
        match (this) {
            case WindowShown => 1
            case WindowActive => 2
            case WindowInactive => 3
            case WindowHidden => 4
            case WindowDestroyed => 7
            case _ => throw BusinessException(100001, "Internal error.")
        }
    }

    static func parse(val: Int32) {
        match (val) {
            case 1 => WindowShown
            case 2 => WindowActive
            case 3 => WindowInactive
            case 4 => WindowHidden
            case 7 => WindowDestroyed
            case _ => throw BusinessException(100001, "Internal error.")
        }
    }
}

/**
* Window stage callback event type.
*
*/
@Derive[Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public enum WindowStageEventType {
    /**
    * The window stage is running in the foreground.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    Shown
    |
    /**
    * The window stage gains focus.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    Active
    |
    /**
    * The window stage loses focus.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    Inactive
    |
    /**
    * The window stage is running in the background.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    Hidden
    |
    /**
    * The window stage is interactive in the foreground.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    Resumed
    |
    /**
    * The window stage is not interactive in the foreground.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    Paused
    | ...

    func getValue(): UInt32 {
        match (this) {
            case Shown => 1
            case Active => 2
            case Inactive => 3
            case Hidden => 4
            case Resumed => 5
            case Paused => 6
            case _ => throw BusinessException(100001, "Internal error.")
        }
    }

    static func parse(val: Int32) {
        match (val) {
            case 1 => Shown
            case 2 => Active
            case 3 => Inactive
            case 4 => Hidden
            case 5 => Resumed
            case 6 => Paused
            case _ => throw BusinessException(100001, "Internal error.")
        }
    }
}

/**
* Describes the window status of an application.
*
*/
@Derive[Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.Window.SessionManager"
]
public enum WindowStatusType {
    /**
    * Undefined status of the window
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.Window.SessionManager"
    ]
    Undefined
    |
    /**
    * Full screen status of the window
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.Window.SessionManager"
    ]
    FullScreen
    |
    /**
    * Maximize status of the window
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.Window.SessionManager"
    ]
    Maximize
    |
    /**
    * Minimize status of the window
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.Window.SessionManager"
    ]
    Minimize
    |
    /**
    * Floating status of the window
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.Window.SessionManager"
    ]
    Floating
    |
    /**
    * Split screen status of the window
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.Window.SessionManager"
    ]
    SplitScreen
    | ...

    func getValue(): UInt32 {
        match (this) {
            case Undefined => 0
            case FullScreen => 1
            case Maximize => 2
            case Minimize => 3
            case Floating => 4
            case SplitScreen => 5
            case _ => throw BusinessException(100001, "Internal error.")
        }
    }

    static func parse(val: Int32) {
        match (val) {
            case 0 => Undefined
            case 1 => FullScreen
            case 2 => Maximize
            case 3 => Minimize
            case 4 => Floating
            case 5 => SplitScreen
            case _ => throw BusinessException(100001, "Internal error.")
        }
    }
}

/**
* Type of allowing the specified of color space.
*
*/
@Derive[Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public enum ColorSpace {
    /**
    * Default color space.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    Default
    |
    /**
    * Wide gamut color space. The specific wide color gamut depends on thr screen.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    WideGamut
    | ...

    func getValue(): UInt32 {
        return match (this) {
            case Default => 0
            case WideGamut => 1
            case _ => throw BusinessException(100001, "Internal error.")
        }
    }

    static func parse(val: Int32): ColorSpace {
        return match (val) {
            case 0 => Default
            case 1 => WideGamut
            case _ => throw BusinessException(100001, "Internal error.")
        }
    }
}

/**
* Enumerates of listening event.
*/
@Derive[Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public enum WindowCallbackType {
    /**
    * indicating the window stage lifecycle change event.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    WindowStageEvent
    |
    /**
    * indicating the window size change event.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    WindowSizeChange
    |
    /**
    * indicating the event of changes to the avoid area.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    WindowAvoidAreaChange
    |
    /**
    * indicating the keyboard height change event.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    KeyboardHeightChange
    |
    /**
    * indicating the click event outside this window.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    TouchOutside
    |
    /**
    * indicating the window visibility change.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    WindowVisibilityChange
    |
    /**
    * indicating the window has no interaction for a long time.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    NoInteractionDetected
    |
    /**
    * indicating the screenshot event.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    Screenshot
    |
    /**
    * indicating the click event of the target window in the modal window mode.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    DialogTargetTouch
    |
    /**
    * indicating the window lifecycle change event.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    WindowEvent
    |
    /**
    * indicating the window status change event.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    WindowStatusChange
    |
    /**
    * indicating the child window close event.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    SubWindowClose
    |
    /**
    * indicating the title buttons area change event.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    WindowTitleButtonRectChange
    |
    /**
    * indicating the window rect change event.
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    WindowRectChange
    | ...

    func getValue(): String {
        match (this) {
            case WindowStageEvent => "windowStageEvent"
            case WindowSizeChange => "windowSizeChange"
            case WindowAvoidAreaChange => "avoidAreaChange"
            case KeyboardHeightChange => "keyboardHeightChange"
            case TouchOutside => "touchOutside"
            case WindowVisibilityChange => "windowVisibilityChange"
            case NoInteractionDetected => "noInteractionDetected"
            case Screenshot => "screenshot"
            case DialogTargetTouch => "dialogTargetTouch"
            case WindowEvent => "windowEvent"
            case WindowStatusChange => "windowStatusChange"
            case SubWindowClose => "subWindowClose"
            case WindowTitleButtonRectChange => "windowTitleButtonRectChange"
            case WindowRectChange => "windowRectChange"
            case _ => throw BusinessException(100001, "Internal error.")
        }
    }
}

/**
* Enumerates of system bar type.
*/
@Derive[Equatable]
@!APILevel[
    22,
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public enum SystemBarType {
    /**
    * status bar
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    Status
    |
    /**
    * navigation
    */
    @!APILevel[
        22,
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    Navigation
    | ...

    func getValue(): String {
        return match (this) {
            case Status => "status"
            case Navigation => "navigation"
            case _ => throw BusinessException(100001, "Internal error.")
        }
    }
}
