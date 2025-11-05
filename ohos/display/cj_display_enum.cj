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
import ohos.hilog.HilogChannel
import ohos.ffi.getOrCreate
import std.deriving.Derive

/**
 * Enumerates the display orientation.
 */
@Derive[Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public enum Orientation {
    /**
     * Indicate that the display content is in portrait mode.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    Portrait
    |
    /**
     * Indicate that the display content is in landscape mode.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    Landscape
    |
    /**
     * Indicate that the display content is in the opposite direction of the portrait mode.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    PortraitInverted
    |
    /**
     * Indicate that the display content is in the opposite direction of the landscape mode.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    LandscapeInverted
    | ...

    static func parse(val: UInt32) {
        match (val) {
            case 0 => Portrait
            case 1 => Landscape
            case 2 => PortraitInverted
            case 3 => LandscapeInverted
            case _ => throw BusinessException(100001, "Internal error.")
        }
    }
}

/**
 * Enumerates the display states.
 *
 */
@Derive[Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.WindowManager.WindowManager.Core"
]
public enum DisplayState {
    /**
     * Unknown.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    StateUnknown
    |
    /**
     * Screen off.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    StateOff
    |
    /**
     * Screen on
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    StateOn
    |
    /**
     * Doze, but it will update for some important system messages.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    StateDoze
    |
    /**
     * Doze and not update.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    StateDozeSuspend
    |
    /**
     * VR node.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    StateVr
    |
    /**
     * Screen on and not update.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.WindowManager.WindowManager.Core"
    ]
    StateOnSuspend
    | ...

    static func parse(val: UInt32) {
        match (val) {
            case 0 => StateUnknown
            case 1 => StateOff
            case 2 => StateOn
            case 3 => StateDoze
            case 4 => StateDozeSuspend
            case 5 => StateVr
            case 6 => StateOnSuspend
            case _ => throw BusinessException(100001, "Internal error.")
        }
    }
}

/**
* Enumerates the fold status.
*
*/
@Derive[Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Window.SessionManager"
]
public enum FoldStatus {
    /**
     * Fold Status Unknown.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    FoldStatusUnknown
    |
    /**
     * Fold Status Expanded.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    FoldStatusExpanded
    |
    /**
     * Fold Status Folded.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    FoldStatusFolded
    |
    /**
     * Fold Status Half Folded. Somehow between fully open and completely closed.
     * For dual-fold axis devices, the first fold axis is half-folded, and the second fold axis is folded.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    FoldStatusHalfFolded
    |
    /**
    * Fold Status Expanded With Second Expanded.
    */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    @!Hide
    FoldStatusExpandedWithSecondExpanded
    |
    /**
    * Fold Status Expanded With Second Half Folded.
    */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    @!Hide
    FoldStatusExpandedWithSecondHalfFolded
    |
    /**
    * Fold Status Folded With Second Expanded.
    */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    @!Hide
    FoldStatusFoldedWithSecondExpanded
    |
    /**
    * Fold Status Folded With Second Half Folded.
    */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    @!Hide
    FoldStatusFoldedWithSecondHalfFolded
    |
    /**
    * Fold Status Half Folded With Second Expanded.
    */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    @!Hide
    FoldStatusHalfFoldedWithSecondExpanded
    |
    /**
    * Fold Status Half Folded With Second Half Folded.
    */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    @!Hide
    FoldStatusHalfFoldedWithSecondHalfFolded
    | ...

    static func parse(val: UInt32) {
        match (val) {
            case 0 => FoldStatusUnknown
            case 1 => FoldStatusExpanded
            case 2 => FoldStatusFolded
            case 3 => FoldStatusHalfFolded
            case _ => throw BusinessException(100001, "Internal error.")
        }
    }
}

/**
* Enumerates the fold display mode.
*
*/
@Derive[Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Window.SessionManager"
]
public enum FoldDisplayMode {
    /**
     * Unknown Display.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    FoldDisplayModeUnknown
    |
    /**
     * Full Display.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    FoldDisplayModeFull
    |
    /**
     * Main Display.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    FoldDisplayModeMain
    |
    /**
     * Sub Display.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    FoldDisplayModeSub
    |
    /**
     * Coordination Display.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    FoldDisplayModeCoordination
    | ...

    func getValue(): UInt32 {
        match (this) {
            case FoldDisplayModeUnknown => 0
            case FoldDisplayModeFull => 1
            case FoldDisplayModeMain => 2
            case FoldDisplayModeSub => 3
            case FoldDisplayModeCoordination => 4
            case _ => throw BusinessException(100001, "Internal error.")
        }
    }

    static func parse(val: UInt32) {
        match (val) {
            case 0 => FoldDisplayModeUnknown
            case 1 => FoldDisplayModeFull
            case 2 => FoldDisplayModeMain
            case 3 => FoldDisplayModeSub
            case 4 => FoldDisplayModeCoordination
            case _ => throw BusinessException(100001, "Internal error.")
        }
    }
}

/**
* Enumerates of listener event.
*/
@Derive[Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Window.SessionManager"
]
public enum ListenerType {
    /**
     * The Add event type.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    ListenerTypeAdd
    |
    /**
     * The Remove event type.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    ListenerTypeRemove
    |
    /**
     * The Change event type.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    ListenerTypeChange
    |
    /**
     * The FoldStatusChange event type.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    ListenerTypeFoldStatusChange
    |
    /**
     * The FoldAngleChange event type.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    ListenerTypeFoldAngleChange
    |
    /**
     * The CaptureStatusChange event type.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    ListenerTypeCaptureStatusChange
    |
    /**
     * The FoldDisplayModeChange event type.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    ListenerTypeFoldDisplayModeChange
    |
    /**
     * The AvailableAreaChange event type.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Window.SessionManager"
    ]
    ListenerTypeAvailableAreaChange
    | ...

    func getValue(): String {
        return match (this) {
            case ListenerTypeAdd => "add"
            case ListenerTypeRemove => "remove"
            case ListenerTypeChange => "change"
            case ListenerTypeFoldStatusChange => "foldStatusChange"
            case ListenerTypeFoldAngleChange => "foldAngleChange"
            case ListenerTypeCaptureStatusChange => "captureStatusChange"
            case ListenerTypeFoldDisplayModeChange => "foldDisplayModeChange"
            case ListenerTypeAvailableAreaChange => "availableAreaChange"
            case _ => throw BusinessException(100001, "Internal error.")
        }
    }
}
