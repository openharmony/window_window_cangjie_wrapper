# Window Cangjie Wrapper<a name="EN-US_TOPIC_0000001076213364"></a>


## Introduction<a name="section15701932113019"></a>

The Window Manager subsystem provides basic capabilities of window and display management. Window Cangjie Interface is only available for standard devices.

## System Architecture

Framework architecture:

![Cangjie window wrapper](./figures/window_window_cangjie_wrapper_en.png)

As illustrated in the architecture:

Interface Layer: Provides a window declaration interface for developers.

- Window: The current window instance, which is the basic unit managed by the window manager. It includes the creation, destruction, and configuration of various properties of the current window.

- WindowStage: The window manager, used to manage Window instances.

- Display: Manages screen properties and provides basic capabilities for handling display devices, including retrieving information about the default display device, obtaining information about all display devices, and monitoring the plugging and unplugging of display devices.

Framework Layer: Based on the underlying window service and display device management service, it encapsulates and implements the Cangjie window management and display device management.

- Window Wrapper: Implemented in Cangjie to encapsulate window instances, interfacing with the window subsystem via Cangjie's C language interoperation.

- WindowStage Wrapper: Implemented in Cangjie to encapsulate the window manager, interfacing with the window subsystem via Cangjie's C language interoperation.

- Display Wrapper: Implemented in Cangjie to encapsulate screen property management capabilities, interfacing with the window subsystem via Cangjie's C language interoperation.

Dependency Component Introduction in the Architecture:

- window_window_manager: The encapsulation of Cangjie interfaces relies on the window services and display device services provided by the Window Management.
- ability_ability_runtime: It depends on the BaseContext query capability provided by Ability Runtime.
- arkui_cangjie_wrapper: Relies on the basic types provided by arkui_cangjie_wrapper.
- ability_cangjie_wrapper: Relies on the AbilityContext interface provided by ability_cangjie_wrapper.
- cangjie_ark_interop: Relies on the API Level capability provided by the cangjie_ark_interop for API management.
- multimedia_cangjie_wrapper: Relies on the Image interface provided by multimedia_cangjie_wrapper.
- hiviewdfx_cangjie_wrapper: Relies on the Hilog interface provided by hiviewdfx_cangjie_wrapper.

## Directory Structure<a name="section1791423143211"></a>

```
foundation/window/window_cangjie_wrapper/
├── figures                           # Architectural diagrams for README
├── ohos                              # Cangjie interface implementation source code directory
│   ├── display                       # Display device management related interface implementation
│   └── window                        # Window management related interface implementation
└── test                              # Test cases directory
```

## When to Use<a name="section171384529150"></a>

Window Cangjie Interface, provide Widnow manage and Display manage API.

The following features are provided:
- Window API: Obtain window instance, pelease refer to [Window](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/arkui-cj/cj-apis-window.md).
- WindowStage API: Manage window units.
- Display API: manage display devices, obtain all display devices info and subscribe display devices

## Limitation

The following features are not provided yet:
- Pipwindow: provides basic APIs for manipulating Picture in Picture (PiP)
- Screenshot: provides the screen capture capability

## Developer Document<a name="section171384529152"></a>

[API Document](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/arkui-cj/cj-apis-window.md)

[Develop Guide](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/summary_cjnative_ohos_EN.md)

## How to Contribute<a name="section171384529153"></a>

Developers are welcome to contribute code, documentation, etc. For specific contribution processes and methods, please refer to [Code Contribution](https://gitcode.com/openharmony/docs/blob/master/en/contribute/how-to-contribute.md).

## Repositories Involved<a name="section1447164910172"></a>

[ability_ability_cangjie_wrapper](https://gitcode.com/openharmony-sig/ability_ability_cangjie_wrapper)

[arkui_arkui_cangjie_wrapper](https://gitcode.com/openharmony-sig/arkui_arkui_cangjie_wrapper)

[arkcompiler_cangjie_ark_interop](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop)

[hiviewdfx_hiviewdfx_cangjie_wrapper](https://gitcode.com/openharmony-sig/hiviewdfx_hiviewdfx_cangjie_wrapper)

[multimedia_multimedia_cangjie_wrapper](https://gitcode.com/openharmony-sig/multimedia_multimedia_cangjie_wrapper)

[ability_ability_runtime](https://gitcode.com/openharmony/ability_ability_runtime)

[window_window_manager](https://gitcode.com/openharmony/window_window_manager)